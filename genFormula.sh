#!/usr/bin/env bash

set -Eeuo pipefail

RELEASE_REPO="${RELEASE_REPO:-nxtrace/NTrace-core}"
API_URL="https://api.github.com/repos/${RELEASE_REPO}/releases/latest"

for cmd in curl jq; do
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "Missing required command: ${cmd}" >&2
    exit 1
  fi
done

if command -v sha256sum >/dev/null 2>&1; then
  CHECKSUM_CMD=(sha256sum)
elif command -v shasum >/dev/null 2>&1; then
  CHECKSUM_CMD=(shasum -a 256)
else
  echo "Missing required command: sha256sum or shasum" >&2
  exit 1
fi

curl_headers=(-H "Accept: application/vnd.github+json")
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  curl_headers+=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
fi

release_json="$(curl -fsSL "${curl_headers[@]}" "${API_URL}")"
tag_name="$(jq -r '.tag_name // empty' <<<"${release_json}")"
if [[ -z "${tag_name}" ]]; then
  echo "Failed to determine latest release tag for ${RELEASE_REPO}." >&2
  exit 1
fi

version="${tag_name#v}"
base_url="https://github.com/${RELEASE_REPO}/releases/download/${tag_name}"
homepage="https://github.com/${RELEASE_REPO}"

declare -a required_platforms=(darwin_amd64 darwin_arm64 linux_amd64 linux_arm64)
declare -A shas
declare -A urls

asset_url() {
  local binary="$1" platform="$2"
  printf '%s/%s_%s' "${base_url}" "${binary}" "${platform}"
}

sha256_for_url() {
  local url="$1"
  local hash_output
  hash_output="$(curl -fsSL "${url}" | "${CHECKSUM_CMD[@]}")"
  printf '%s' "${hash_output%% *}"
}

collect_assets() {
  local binary="$1"
  local platform url hash key

  for platform in "${required_platforms[@]}"; do
    url="$(asset_url "${binary}" "${platform}")"
    echo "Calculating sha256 for ${binary} ${platform} (${url})" >&2
    hash="$(sha256_for_url "${url}")"
    if [[ -z "${hash}" ]]; then
      echo "Failed to compute sha256 for ${url}" >&2
      exit 1
    fi
    key="${binary}:${platform}"
    urls["${key}"]="${url}"
    shas["${key}"]="${hash}"
  done

  platform="linux_armv7"
  url="$(asset_url "${binary}" "${platform}")"
  if curl -fsI "${url}" >/dev/null 2>&1; then
    echo "Calculating sha256 for ${binary} ${platform} (${url})" >&2
    hash="$(sha256_for_url "${url}")"
    if [[ -z "${hash}" ]]; then
      echo "Failed to compute sha256 for ${url}" >&2
      exit 1
    fi
    key="${binary}:${platform}"
    urls["${key}"]="${url}"
    shas["${key}"]="${hash}"
  fi
}

formula_path_for() {
  local formula_name="$1"
  printf 'Formula/%s.rb' "${formula_name}"
}

render_formula() {
  local formula_name="$1" class_name="$2" binary="$3" desc="$4"
  local formula_path linux_arm_block

  formula_path="$(formula_path_for "${formula_name}")"
  mkdir -p "$(dirname "${formula_path}")"

  printf -v linux_arm_block '    else\n      odie "Unsupported Linux architecture for %s"\n    end' "${binary}"
  if [[ -n "${shas[${binary}:linux_armv7]:-}" ]]; then
    printf -v linux_arm_block '    elsif Hardware::CPU.arm?\n      url "%s"\n      sha256 "%s"\n    else\n      odie "Unsupported Linux architecture for %s"\n    end' \
      "${urls[${binary}:linux_armv7]}" "${shas[${binary}:linux_armv7]}" "${binary}"
  fi

  cat >"${formula_path}" <<EOF
class ${class_name} < Formula
  desc "${desc}"
  homepage "${homepage}"
  version "${version}"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "${urls[${binary}:darwin_amd64]}"
      sha256 "${shas[${binary}:darwin_amd64]}"
    elsif Hardware::CPU.arm?
      url "${urls[${binary}:darwin_arm64]}"
      sha256 "${shas[${binary}:darwin_arm64]}"
    else
      odie "Unsupported macOS architecture for ${binary}"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "${urls[${binary}:linux_amd64]}"
      sha256 "${shas[${binary}:linux_amd64]}"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "${urls[${binary}:linux_arm64]}"
      sha256 "${shas[${binary}:linux_arm64]}"
${linux_arm_block}
  end

  def install
    binary = Dir["${binary}_*"].first
    odie "${binary} binary not found" unless binary
    chmod 0755, binary
    bin.install binary => "${binary}"
  end

  test do
    assert_match "NextTrace", shell_output("#{bin}/${binary} -V")
  end
end
EOF

  echo "Updated ${formula_path} for ${tag_name}" >&2
}

declare -a flavors=(
  "nexttrace|Nexttrace|nexttrace|Open source visual route tracking CLI tool"
  "nexttrace-tiny|NexttraceTiny|nexttrace-tiny|Lightweight NextTrace traceroute CLI"
  "ntr|Ntr|ntr|MTR-focused NextTrace CLI"
)

for flavor in "${flavors[@]}"; do
  IFS='|' read -r _ class_name binary desc <<<"${flavor}"
  collect_assets "${binary}"
done

for flavor in "${flavors[@]}"; do
  IFS='|' read -r formula_name class_name binary desc <<<"${flavor}"
  render_formula "${formula_name}" "${class_name}" "${binary}" "${desc}"
done

#!/usr/bin/env bash

set -Eeuo pipefail

REPO="nxtrace/NTrace-V1"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"
FORMULA_PATH="Formula/nexttrace.rb"

# Ensure required tools are present
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

release_json="$(curl -fsSL "${API_URL}")"
tag_name="$(jq -r '.tag_name // empty' <<<"${release_json}")"
if [[ -z "${tag_name}" ]]; then
  echo "Failed to determine latest release tag." >&2
  exit 1
fi

version="${tag_name#v}"
base_url="https://github.com/${REPO}/releases/download/${tag_name}"

declare -A assets=(
  [darwin_universal]="${base_url}/nexttrace_darwin_universal"
  [linux_amd64]="${base_url}/nexttrace_linux_amd64"
  [linux_arm64]="${base_url}/nexttrace_linux_arm64"
)

armv7_asset="${base_url}/nexttrace_linux_armv7"
if curl -fsI "${armv7_asset}" >/dev/null 2>&1; then
  assets[linux_armv7]="${armv7_asset}"
fi

declare -A shas
for key in "${!assets[@]}"; do
  url="${assets[${key}]}"
  echo "Calculating sha256 for ${key} (${url})" >&2
  hash_output="$(curl -fsSL "${url}" | "${CHECKSUM_CMD[@]}")"
  shas["${key}"]="${hash_output%% *}"
  if [[ -z "${shas[${key}]}" ]]; then
    echo "Failed to compute sha256 for ${url}" >&2
    exit 1
  fi
done

mkdir -p "$(dirname "${FORMULA_PATH}")"

printf -v linux_arm_block '    else\n      odie "Unsupported Linux architecture for nexttrace"\n    end'
if [[ -n "${shas[linux_armv7]:-}" ]]; then
  printf -v linux_arm_block '    elsif Hardware::CPU.arm?\n      url "%s"\n      sha256 "%s"\n    else\n      odie "Unsupported Linux architecture for nexttrace"\n    end' \
    "${assets[linux_armv7]}" "${shas[linux_armv7]}"
fi

cat >"${FORMULA_PATH}" <<EOF
class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "${version}"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    url "${assets[darwin_universal]}"
    sha256 "${shas[darwin_universal]}"
  end

  on_linux do
    if Hardware::CPU.intel?
      url "${assets[linux_amd64]}"
      sha256 "${shas[linux_amd64]}"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "${assets[linux_arm64]}"
      sha256 "${shas[linux_arm64]}"
${linux_arm_block}
  end

  def install
    binary = Dir["nexttrace_*"].first
    odie "nexttrace binary not found" unless binary
    chmod 0o755, binary
    bin.install binary => "nexttrace"
  end

  test do
    assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
  end
end
EOF

echo "Updated ${FORMULA_PATH} for ${tag_name}" >&2

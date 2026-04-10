class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.6.2"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.2/nexttrace_darwin_amd64"
      sha256 "3dfd521df5b09801746d7bd35dce6ed13e27952add87b1952fb2af32bdc8d661"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.2/nexttrace_darwin_arm64"
      sha256 "1ae05e62bfb80ae732290368d74ab476f19786fee1a9285bff3f1dbc07712d05"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.2/nexttrace_linux_amd64"
      sha256 "9f57d8936087c6fb3435b9e98d4f6ac9a5bd60d9ef3c10c8f75f2d011c717a9e"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.2/nexttrace_linux_arm64"
      sha256 "4689f6528139f63d2e0038b584fa6d9bcf21ab7b838760a87055925868747501"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.2/nexttrace_linux_armv7"
      sha256 "86672f856150dc823b6d450c4b70c33c6be8f9ab302295ed51a78953400a4150"
    else
      odie "Unsupported Linux architecture for nexttrace"
    end
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

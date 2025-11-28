class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.0"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0/nexttrace_darwin_amd64"
      sha256 "89c001fcf6a1b0681ec6f93f6ff779c41bda07ec58c027bd68e551b0a0b9a5d9"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0/nexttrace_darwin_arm64"
      sha256 "a4af51b2d26e388164cd1019d2e2c22259bc699c5b3f9442bbb4e2098290387d"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0/nexttrace_linux_amd64"
      sha256 "212a10aa4b28c2e0fbf97f8c14b3c0c02851e09e04edecdc450bcbe9e861766f"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0/nexttrace_linux_arm64"
      sha256 "ee3b3e63f11292a35c30d3c3b84e683ac855d8c68665d5d9a1095e87da6df509"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0/nexttrace_linux_armv7"
      sha256 "6151c72e13fbc66493ac58c795e0bde2edfc5937206f2c386ad6ae5c325d2414"
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

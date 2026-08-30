class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.3"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace_darwin_amd64"
      sha256 "0c266dea69e718e6cbbce642a0ec0ff3c513a47298e864906aa9229252e91fb3"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace_darwin_arm64"
      sha256 "32d6ea209beedab088ba4e954d7e28d6bf2561991baf92633a684d1e37c2a0d1"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace_linux_amd64"
      sha256 "aa75440fcdee46c16d941f48f9dabee1eb4c35bea6b739b0960fcf8307088c29"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace_linux_arm64"
      sha256 "4fbf436e2d4737e4a491e71ce3cd140a7a268d43ec94fb9ac9497aec7eda080e"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace_linux_armv7"
      sha256 "d7741bd54a5cae13acf5decb6576216fb355f9dfbcb830b29aea092e08606979"
    else
      odie "Unsupported Linux architecture for nexttrace"
    end
  end

  def install
    binary = Dir["nexttrace_*"].first
    odie "nexttrace binary not found" unless binary
    chmod 0755, binary
    bin.install binary => "nexttrace"
  end

  test do
    assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
  end
end

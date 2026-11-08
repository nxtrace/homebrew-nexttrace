class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.6"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace-tiny_darwin_amd64"
      sha256 "d0e0cd7ed1ed4728968a2097f88d4650212eaf1c6687d1bf61311e7e5adb90db"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace-tiny_darwin_arm64"
      sha256 "6e441056b9709b7b6862be82d946545a78784dd481a6fc18f738efc03fda93c3"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace-tiny_linux_amd64"
      sha256 "9f219ba91318a3e1534bd28c661ef8019da42825ed48257035c508962d007271"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace-tiny_linux_arm64"
      sha256 "aeab456e2f8aebd62cd1dd2d6458d2ec57b38f5d707e196bab41f999ff898810"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace-tiny_linux_armv7"
      sha256 "deef6df56fcaefd14737859ad545d941cb1bffbf6b02702aba1b9aefad317614"
    else
      odie "Unsupported Linux architecture for nexttrace-tiny"
    end
  end

  def install
    binary = Dir["nexttrace-tiny_*"].first
    odie "nexttrace-tiny binary not found" unless binary
    chmod 0755, binary
    bin.install binary => "nexttrace-tiny"
  end

  test do
    assert_match "NextTrace", shell_output("#{bin}/nexttrace-tiny -V")
  end
end

class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace-tiny_darwin_amd64"
      sha256 "26047ce0031f09b7581f0cd4735fb0c065d404bd36743ce940ec0b8e98ae06ac"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace-tiny_darwin_arm64"
      sha256 "93b742547518c7fd145a083fd31e566ab2bdfc70ead366ac54228693dfa48d2c"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace-tiny_linux_amd64"
      sha256 "093849f1012b065c29d307b8e47fedec667206829c14e105f83a852f60c628d1"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace-tiny_linux_arm64"
      sha256 "8b134f6c6a7864b1ecc98b1f7cfae1d058ef6dcf8f0da862e3260752ce1858bd"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace-tiny_linux_armv7"
      sha256 "71014f2707372cee22ab80f546aa6cff79d869faab0fb516005e8bb0e2d2f000"
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

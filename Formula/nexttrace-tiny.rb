class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.0"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace-tiny_darwin_amd64"
      sha256 "dc40a2c4ec50c16cb465aedb631b4926ae11478e0ce1be4cd5c772c2437bf778"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace-tiny_darwin_arm64"
      sha256 "a0117b6497874620d8f89b633a41f33a9b9925e6311f146f1cdbf393dc25efb1"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace-tiny_linux_amd64"
      sha256 "aff2133ad86813b5779c4bc8e94708ef17136294266a04795e8dc23347a292b8"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace-tiny_linux_arm64"
      sha256 "24c068d5804cbabba0c1771eb0dc1e3bee5cd27138cfb972136dc8a04055a4e9"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace-tiny_linux_armv7"
      sha256 "fca030d9e8ae6514024abd29f83ff14d0151e59c56d8160bc7164b85444113ea"
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

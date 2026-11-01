class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace-tiny_darwin_amd64"
      sha256 "82e2ffabbea73c0928f5d3ddf8bc74cad3128e3fbd5bd316c2e7fdd0865441d1"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace-tiny_darwin_arm64"
      sha256 "854d25ac2704f5463cd95fa4d4ea235f28d2b2a49df39648980bf419db0b3db6"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace-tiny_linux_amd64"
      sha256 "4c25ab6f4000f1473ab928362e406ba0288cbdc034857eeedd83bb0e4d3ce653"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace-tiny_linux_arm64"
      sha256 "e49e5d5cf6fa45ec4b7ac739eba674412b1e044d7502d56878c67ec8cde6c1d4"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace-tiny_linux_armv7"
      sha256 "c837162b5e1b2c0ef08f8c33b5cbb4a0b989430457f11f6f61fc5e3cd8f6d084"
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

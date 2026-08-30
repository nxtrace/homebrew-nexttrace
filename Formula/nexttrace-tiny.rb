class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.3"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace-tiny_darwin_amd64"
      sha256 "53f1832ed400d73f3d2fce7ec8c42498061f7ba04f552d73291f87961afbefd5"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace-tiny_darwin_arm64"
      sha256 "56916ba98379e0bb227338cbad326624d3ac74e1f32da033bce55c8cf09a88d8"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace-tiny_linux_amd64"
      sha256 "52b4a69aa2108332f53ca2e73ffdb2937cb6cf80a6f1730765fe2209ca720f7d"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace-tiny_linux_arm64"
      sha256 "10c8a06c9f516b737c82a2c7ce6571e3a1165bf420805b508f384af277f31147"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/nexttrace-tiny_linux_armv7"
      sha256 "4063e34bfb2bea50a9f2bdb141c27f8d94b8d052036c4989a532beadd3954162"
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

class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.2-rc.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.5/nexttrace_darwin_amd64"
      sha256 "1a6e1b16692540c7d20c2326447d541c0738e2039a7da2181f7d20343fb23873"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.5/nexttrace_darwin_arm64"
      sha256 "e58233e97d82c8985f8b61759df436136b33fb0b96aed499ebb327faed7a89ba"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.5/nexttrace_linux_amd64"
      sha256 "e0cab0dac45dffe1789557ece551d9ab1ee25f3da956f8603a7680bb0357944d"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.5/nexttrace_linux_arm64"
      sha256 "48682554db078567591b34017b0b15a5e8ebf4392090e01680a3daf8762eae04"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.5/nexttrace_linux_armv7"
      sha256 "4e636f16c01abe4a7c08af26b3cab24e0bc95277ebf3a1f8d4654e0374a5c29c"
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

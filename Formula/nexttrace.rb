class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.2-rc.2"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.2/nexttrace_darwin_amd64"
      sha256 "3060421bd2482a86524eafab192568e46010ffcf8846f8f9e46e6646c24f7f78"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.2/nexttrace_darwin_arm64"
      sha256 "47ef74d417fa2e6143fc312ed0052bae337ffadb187b99ba5f8b6761d8a5fe75"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.2/nexttrace_linux_amd64"
      sha256 "9ef01a247e8101ae98e23941fffc26cabbaf2c6687d62b6d59cc7bafc939a8c0"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.2/nexttrace_linux_arm64"
      sha256 "592ae3d10959acc6d448e9f2bd8b8bd2e9bf3a25953761c928e3b2d3657726b0"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.2/nexttrace_linux_armv7"
      sha256 "79068c03ae860efa6e267cf5df5b1aa34a586d660ffcf084d1b47b6eb7289cc1"
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

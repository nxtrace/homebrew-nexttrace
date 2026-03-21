class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.6.0"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.0/nexttrace_darwin_amd64"
      sha256 "5ca6d1fdadd5996be46fe503d3b6179420fbaf3d7a1904a0b733ccf601424604"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.0/nexttrace_darwin_arm64"
      sha256 "4b98b9447475eae41195d23f61b148a3774d8035e7988d2481ffa214fa545fc3"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.0/nexttrace_linux_amd64"
      sha256 "46298fffc63993f07cd7b0fc62056ed7adcb7b8f6f0f8b8cfaf56ebb64ba8ccf"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.0/nexttrace_linux_arm64"
      sha256 "c0174f93a6453bd55773dc200e61a09fbe72d94bf3e92d67335411bdb77be3a7"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.0/nexttrace_linux_armv7"
      sha256 "6eb024c9eb31e3ec2282bf43cc71e6137b3b35d74e96180249e3f4b2918063fb"
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

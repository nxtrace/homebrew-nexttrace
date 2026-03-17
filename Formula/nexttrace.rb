class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.2"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2/nexttrace_darwin_amd64"
      sha256 "1a553fae5761a9ce50d312876cf56b21d70d1520748edef57b289041a592596a"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2/nexttrace_darwin_arm64"
      sha256 "298398d46cf4c888c146f8dd1712404711168195f672c35bed2cd5bc0ade9872"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2/nexttrace_linux_amd64"
      sha256 "cac1e19f417c316897e79b07a403fc2f5417bfe72872380022690705b27f1353"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2/nexttrace_linux_arm64"
      sha256 "85de574a8695b41aec7d118f07f30a55d4de4877e00259a78fd5922226ed54b1"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2/nexttrace_linux_armv7"
      sha256 "13145c8a9677eaf870318ae476949625ea9cc6946958abf1bd03cb37e223ba55"
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

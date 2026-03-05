class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.2-beta.0"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-beta.0/nexttrace_darwin_amd64"
      sha256 "284759547dbbc7b4f9c3aa4b3a00f5298ce553832ce9aec8359f8131fc9499ee"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-beta.0/nexttrace_darwin_arm64"
      sha256 "2801dacbbb4de6ab8a6d923e860dfdfd67f40e88dfeb397c952c648adfebfe57"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-beta.0/nexttrace_linux_amd64"
      sha256 "8c87ab963a4e608ecce60a1269a97dd1e3e7611a7bd03d344c872faf819f1043"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-beta.0/nexttrace_linux_arm64"
      sha256 "2befb0a5959cecd1a5443a5e68941064fc812fd04d0a072cb63073484f877c16"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-beta.0/nexttrace_linux_armv7"
      sha256 "f21bb13d89d68b3dd857f31a95365aecc2fc90e742f6148b2d51bf64c1029408"
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

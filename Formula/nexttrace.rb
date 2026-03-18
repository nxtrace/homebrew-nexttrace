class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.3"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.3/nexttrace_darwin_amd64"
      sha256 "494224771f56b470374f1a9a8ac9ce40fb5bf7f8e5dff5903d5bc967c5393d6f"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.3/nexttrace_darwin_arm64"
      sha256 "79719dcad0c07ebd3fd5ba91645baf2bc9896a7789fe4ea64489c31df93de4ea"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.3/nexttrace_linux_amd64"
      sha256 "46c5542b639e269b3faae886630431b851e031587169f07770b8156351ed3acc"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.3/nexttrace_linux_arm64"
      sha256 "937b1490b7926735f88c2e7755f6f13ed0bdb28084bc59c7bc8932ede4ebcbd8"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.3/nexttrace_linux_armv7"
      sha256 "d57aa814b4d5768890c0911d9a9047947e4e3adfbc1043c07386a2231c4637c2"
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

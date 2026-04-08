class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.6.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.1/nexttrace_darwin_amd64"
      sha256 "c83984ca500831d668c1784e5b5902879dc84d227bb499ad3f1d9eb7a08e733e"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.1/nexttrace_darwin_arm64"
      sha256 "0a77c4568c28939b0bed49041020dc9a5c6d2cee75f54654e10652c7783da7c6"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.1/nexttrace_linux_amd64"
      sha256 "16748fc51f97aaebe110ed110f85f4faa5c5897073099c0994980e6eb706b900"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.1/nexttrace_linux_arm64"
      sha256 "87f62c71744a98cca7d0a271809a7896cd64416f305c8c26be2d09a8d598c3db"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.1/nexttrace_linux_armv7"
      sha256 "6505682754ee597d0ad51cf9a74fa237381ceb7974ab10d5ca4d4fca1a6b7618"
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

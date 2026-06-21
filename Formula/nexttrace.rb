class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace_darwin_amd64"
      sha256 "c9b67907fc0bd70fa89b9717c43d0ae059475efbc162eddb3f3863aea408f535"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace_darwin_arm64"
      sha256 "5ebc87cf3fd408cec73b3f07a1e6745ecb0a0de3e2db2384d50103c26265369b"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace_linux_amd64"
      sha256 "1f4c559cbdf6f667a1a9e050567c9cf1fc11741e8cc1e50f5fdcaf2dbb247232"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace_linux_arm64"
      sha256 "9c2f1b79e7d0e37f59ebe685aec1d5c41fb8f3407f54e17b34656712eaa66fd9"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/nexttrace_linux_armv7"
      sha256 "1eb8be9394b2ac40a991d4fa3e651960e107bc8c6757a35c5f4720c0ab8eb71d"
    else
      odie "Unsupported Linux architecture for nexttrace"
    end
  end

  def install
    binary = Dir["nexttrace_*"].first
    odie "nexttrace binary not found" unless binary
    chmod 0755, binary
    bin.install binary => "nexttrace"
  end

  test do
    assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
  end
end

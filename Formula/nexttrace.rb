class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace_darwin_amd64"
      sha256 "c139893c96371f59677abbd57d403b71c25b7edce60b2b39ff4fce9b445299e7"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace_darwin_arm64"
      sha256 "c85e7725cb58bb74ab51b440005bdd37a2a3aced322c3c80cd88e0d46911b74a"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace_linux_amd64"
      sha256 "7d7fa3bdd967494d1c051766696dea753bc6f4a1d95c2016fdfa078cf1894ff6"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace_linux_arm64"
      sha256 "820a736c60aca52683b5a4c7fa256d7a4248db37f28f2c16ff6daf76a8b0ee87"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/nexttrace_linux_armv7"
      sha256 "f8d03b2627b375030d0cf75af41a65b9facb4406dcef72149f469493290b5404"
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

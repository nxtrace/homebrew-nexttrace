class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.0"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace_darwin_amd64"
      sha256 "d865adca599c007c8d522e0bcd55e3135927c187c2c3f82ba3a63d301946bf90"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace_darwin_arm64"
      sha256 "2469055436ab1a66fa35bbc62ca477ddc6d95cb4744f4e6dd4c3c9027bd700c7"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace_linux_amd64"
      sha256 "f3733cdada37633b8cde7e04515fe455bb7bdc8bc3aa8cd086dd52ca7d522683"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace_linux_arm64"
      sha256 "52d1bbdd642aa7c9e712aa996d117d08d2121c869ce708815229011c062ec7d8"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/nexttrace_linux_armv7"
      sha256 "9173d53c10cc1ceeb33967748ac4ba561eec0b5716dd49da2e7f10d553d7aa9d"
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

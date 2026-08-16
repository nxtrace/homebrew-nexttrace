class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.2"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace_darwin_amd64"
      sha256 "f7e0a1a596565223863fce9eb80a339228b18a149d1b937479690d398f5d9afc"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace_darwin_arm64"
      sha256 "65fbed771b25082c4eaa81def0953834f3b7db353a5f8d136bebd1978e6115a6"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace_linux_amd64"
      sha256 "efaa5399e25a1ab174055546d6e3b8c54d454d453a53587f19b6024ea78c78b5"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace_linux_arm64"
      sha256 "154a4dd4d7666bffc7dcbb313d95b2246e4142f367bc1636f557ee0c23af5c12"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace_linux_armv7"
      sha256 "0021146587700bce4f45a88d04d7aa14a0d499f1d3c7e751bf0937351b6bfaba"
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

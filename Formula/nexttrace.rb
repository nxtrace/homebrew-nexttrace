class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.6.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace_darwin_amd64"
      sha256 "6435965752bdc30ac8da7be850c273077901f987f14d704bbc6f8168b4cc9a8a"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace_darwin_arm64"
      sha256 "939ca02dc7581be2e83a61e17a86902e4cd02183344cc9890c71233667cf428f"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace_linux_amd64"
      sha256 "32e4b43ba72709d8cb16585194315cf316d376cbd14013c58cece90d3764e090"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace_linux_arm64"
      sha256 "07f9c8f74c856bd90b006881527b14240062cb332d84f0be3095fc6f509ce0b1"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace_linux_armv7"
      sha256 "e4b077c7a5fe126891e531ecc5dc817b689f02d4895c477c217f05f3c9302840"
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

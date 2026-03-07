class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.2-rc.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.1/nexttrace_darwin_amd64"
      sha256 "ab1c84f52adc239485429b4d2a0b41904cad1f090075672c440f427e47b18533"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.1/nexttrace_darwin_arm64"
      sha256 "d077726d2c5af5dc52e13c89ed6db89a430b77ac8f7dae5e9787eeedd9ca1fdb"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.1/nexttrace_linux_amd64"
      sha256 "7e2deabd913a91ff12b33c0b1651e58d28d198d8d6a9807967ac9ae819f9bbfc"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.1/nexttrace_linux_arm64"
      sha256 "d1c9bb335aed264b8d196e0b1f62a4ae9ba04231fc777604ee31d4ad55a35f8a"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.1/nexttrace_linux_armv7"
      sha256 "dff28df1ec6b55638953e607207bceb8c804b59f13dd5b943073e8b344b46c75"
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

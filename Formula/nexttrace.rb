class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.1-rc.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.1-rc.1/nexttrace_darwin_amd64"
      sha256 "894214946fd0f4b51dffc27cd579ad0814dd639b3fadfa6b0a468ac62ab7ad04"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.1-rc.1/nexttrace_darwin_arm64"
      sha256 "1260ad8b2b707cee4d8febd3cbc6dfc4b33f42600b1b8f3e04682d16e959a3e6"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.1-rc.1/nexttrace_linux_amd64"
      sha256 "a40ee4d1d3c8d34cf50227f17b8c72bd9db621ba1d09a63b1badd8f41a9311fd"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.1-rc.1/nexttrace_linux_arm64"
      sha256 "2d28e12711fc9292cec8ab2bd314e0a26d61246a0a74d170ccbf5dd85cb19eb6"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.1-rc.1/nexttrace_linux_armv7"
      sha256 "50fd28f10ce9d5e0c83103598bc480d150ff4584456d12f9699b320847a9fb50"
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

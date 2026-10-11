class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.4"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace_darwin_amd64"
      sha256 "a13748fb79382e62ba2a558840c1f561104f3d05f31fa688cb6455536e8c179b"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace_darwin_arm64"
      sha256 "d4ad341875d65769bfc05dbee8cade9e6f3c9052c14a279dd7db993fab06632a"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace_linux_amd64"
      sha256 "25100992ad8924d6bfc7724eb6cc98547d87ec13828aa9b354516687331e170c"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace_linux_arm64"
      sha256 "84e8dee2115263e3627580382dcb355cf364d5cc4fd4a2a106ac2fd989476834"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace_linux_armv7"
      sha256 "48400abdf899061356040b15f05f284f199fd3c837631c976cec56ff6c736aa1"
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

class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.2-rc.4"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.4/nexttrace_darwin_amd64"
      sha256 "3a2a061ebb743e0dc5614d95b7d0dbf9015f06a4a7711b23615a09801366fda0"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.4/nexttrace_darwin_arm64"
      sha256 "f1e9d431f00436fc3e3b6f9fbb69dee4a42865d15c990a197ed612aee7cccfa2"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.4/nexttrace_linux_amd64"
      sha256 "40ecb213b54f6d4aa698ae3a41dc8b739a01213b65505c5bf441c396abfaac83"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.4/nexttrace_linux_arm64"
      sha256 "f744452e895d93f5155efa47b3580d8da107a7781868d2636555e710b8a2506c"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.4/nexttrace_linux_armv7"
      sha256 "208f43970b29f0a27809a5b8ecff20a1bdd3c53be76c68bba416d4c603cd5a30"
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

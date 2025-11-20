class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.0-beta.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-beta.1/nexttrace_darwin_amd64"
      sha256 "3408ff72df96ee18901593eb71614c53b2fc22f72f99f918635482e3f0a1e9a0"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-beta.1/nexttrace_darwin_arm64"
      sha256 "c04ac5ecb111a3c55449db5a98cf2f67cc0cc77f5663cb144a128bc1bc6dff99"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-beta.1/nexttrace_linux_amd64"
      sha256 "a29ae46927ea9d63db1647631bb919894b086390bca88617732acb13df057369"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-beta.1/nexttrace_linux_arm64"
      sha256 "6e4d21fa2a2c1131b721a1212e417d505c72d9abbac98da218aa9067fece7eec"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-beta.1/nexttrace_linux_armv7"
      sha256 "f5f4477dae2bef1a121c49c5c5dcd4df723213977ff41595fd999204c04d99a4"
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

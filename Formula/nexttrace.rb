class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.0-rc.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-rc.1/nexttrace_darwin_amd64"
      sha256 "bf791223aa81aa356f50238a20713d32b4ac857ce86305ae5af9d201c59f1fc7"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-rc.1/nexttrace_darwin_arm64"
      sha256 "d2c327e4b0a112b43d53033c1feef79ffddb736598d75a982751cc62bbb8a510"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-rc.1/nexttrace_linux_amd64"
      sha256 "bd39775ef273176a4439d2d345fabd91202e46b835cf17011cdd185487f78727"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-rc.1/nexttrace_linux_arm64"
      sha256 "c4393cd125cd535f7e3fb282002d6129c18706ea4686753400a0c2b2bdf1a827"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.0-rc.1/nexttrace_linux_armv7"
      sha256 "326e0ed0bc92d69e9a75da8945fdc82f19767aca7ae62cd99b95a695d7259d65"
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

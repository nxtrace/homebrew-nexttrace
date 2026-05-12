class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.6.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.5/nexttrace_darwin_amd64"
      sha256 "24b945726ed895a94d31d64a1bfcd711d42bcb264fa3e14683aacbb354c88441"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.5/nexttrace_darwin_arm64"
      sha256 "7f343c61bf221106b8ae3d7fffeb8e0a2a647da2d9dcd0b12bea2775f9089456"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.5/nexttrace_linux_amd64"
      sha256 "daca425addfb7cc280804dbcfdd8ecc3a7708f8af25fa79a95fbe71dffdbc078"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.5/nexttrace_linux_arm64"
      sha256 "1ce0e618a63d518c24a9cfed2ca81bd6df4b4d940cae49828c86ee9091bbdb93"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.5/nexttrace_linux_armv7"
      sha256 "6f22c1852bc74818d4d15cb967d379573fb43b3aa54fdb2629ed4f38b924ebf4"
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

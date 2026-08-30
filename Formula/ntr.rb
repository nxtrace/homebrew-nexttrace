class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.3"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/ntr_darwin_amd64"
      sha256 "9379ccd7b8f95be9a93477c12090d53366987b0b66f796cc12fc4748d5d406d9"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/ntr_darwin_arm64"
      sha256 "4c0d8a5fd3c461a574ad310c496f38b64d5a15c1cbdcfd2cc14e13fd321d5fbf"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/ntr_linux_amd64"
      sha256 "c409d61a63fc27158d553769a834cb49645fc09c37dc20b17ad962339ddf3228"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/ntr_linux_arm64"
      sha256 "3480260ecf833942940823a2bac064160cc7da6a9b008eac4a38425073ae2a96"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.3/ntr_linux_armv7"
      sha256 "bcf767da0392db9b336a8b1bd66cc0388ac2dab157402a8d9aa20d20948033a5"
    else
      odie "Unsupported Linux architecture for ntr"
    end
  end

  def install
    binary = Dir["ntr_*"].first
    odie "ntr binary not found" unless binary
    chmod 0755, binary
    bin.install binary => "ntr"
  end

  test do
    assert_match "NextTrace", shell_output("#{bin}/ntr -V")
  end
end

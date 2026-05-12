class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.6.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/ntr_darwin_amd64"
      sha256 "56bdc0bda7b2cfb190b436ae492786ed0c6d313e10afa3889bc322ddb9489857"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/ntr_darwin_arm64"
      sha256 "223d390aa5c3b00e6f2eec7e54d4acf3200b656dff5856ee2a93ad3d0637c177"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/ntr_linux_amd64"
      sha256 "06c9ea4b37c59f49fe6d9c77e97699f0edec9b94dddeb4729749f9e6d8bb9fd5"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/ntr_linux_arm64"
      sha256 "aafb46332adce4264de30168b725502e8ac3ddf754fedcef2573b48f3f791587"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/ntr_linux_armv7"
      sha256 "4f9a12848beedf1a8efa3d2087b8e4ee803a0051cb2263a986f540f7b3ddb86d"
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

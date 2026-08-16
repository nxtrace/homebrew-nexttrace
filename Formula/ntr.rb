class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.2"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/ntr_darwin_amd64"
      sha256 "f3381c267e3d46ac2acc19f86af4477c2248a7cd548f84e3dc00f07b7ea8cf7f"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/ntr_darwin_arm64"
      sha256 "948ede355c195eff3f7a3f6226a59ec81bc768f6dc71d19d655546293b0ce804"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/ntr_linux_amd64"
      sha256 "d7bebe2f151a2248c9fa100739d13c44456d7592a384ab4e74025e90ea417196"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/ntr_linux_arm64"
      sha256 "807b4d942062cec5e33041fba5cd618aa9f354f21aeb1ebf2ac6d2013459a2fd"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/ntr_linux_armv7"
      sha256 "d0095ba00e4b3f4ebdf0cfea6bdfa573cc745b30e162ba7da1c4fbeb6022c7ce"
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

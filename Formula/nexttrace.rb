class Nexttrace < Formula
  desc "Open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.6"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace_darwin_amd64"
      sha256 "a8fb1d06256bc5995a2cb5ee297443e36ea41da490d877d084217c66f6550e14"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace_darwin_arm64"
      sha256 "ca8b67282900454d853abfad9b610786e0c22738ab9b2277382ac60d30250155"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace_linux_amd64"
      sha256 "3868c8190c961b534b8f2d0ed528796fc48d46a818ee5268fe2dfc6aa44b3a5e"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace_linux_arm64"
      sha256 "e4c4e818f6cebf8d8ee3df3976a304c8bac2bb3bea3160a23fd5bce18095c9e6"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/nexttrace_linux_armv7"
      sha256 "fa75a10ec7b82fa19c18af5e49ffaa4383433a29503001c792708dccec044f70"
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

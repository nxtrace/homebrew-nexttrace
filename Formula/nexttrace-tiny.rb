class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.6.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace-tiny_darwin_amd64"
      sha256 "4141c37b993de360889759972ec0aa180e9ecc6daaf0f16688b65b09ae095367"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace-tiny_darwin_arm64"
      sha256 "3727aba57394dc865345d7ba5f840c2fa272eeff6c78566604639de4f0b2f1e3"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace-tiny_linux_amd64"
      sha256 "2d95d359bbf8e98d1101c28e9dbf1ed85b441581838164b83be4daa96752d3ed"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace-tiny_linux_arm64"
      sha256 "2031f30f21496a6c5e971df2522993e0a0af69116cc44fff59623d94c7aab5bc"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.6.5/nexttrace-tiny_linux_armv7"
      sha256 "819b2b70935f3eb6384e6190aae4585f4ef933cc4ef18a3f5e2ebf8be4fd56fc"
    else
      odie "Unsupported Linux architecture for nexttrace-tiny"
    end
  end

  def install
    binary = Dir["nexttrace-tiny_*"].first
    odie "nexttrace-tiny binary not found" unless binary
    chmod 0755, binary
    bin.install binary => "nexttrace-tiny"
  end

  test do
    assert_match "NextTrace", shell_output("#{bin}/nexttrace-tiny -V")
  end
end

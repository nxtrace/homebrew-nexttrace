class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.2"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace-tiny_darwin_amd64"
      sha256 "c541d352e00b6366ffc6c6906c0fc0ac85d93e1b7e494645f23d06eca6ef4d73"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace-tiny_darwin_arm64"
      sha256 "74254a8856567f9bb6a024671e65e4123d5beab24222c814f20673a8837ef515"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace-tiny_linux_amd64"
      sha256 "762dfce602a5815f8480a950dd4c15a3bd0f8172aae30a991ccf02ba9f38c082"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace-tiny_linux_arm64"
      sha256 "c3a3c4a58c875625d9e30496e52fe0d57f0bee60b31539d4d43da4a9fd37ebfc"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.2/nexttrace-tiny_linux_armv7"
      sha256 "31250ec6c2ba1b55fbd2d507ff7e343bab1b0d1535cdc1bc686d36a5494c86db"
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

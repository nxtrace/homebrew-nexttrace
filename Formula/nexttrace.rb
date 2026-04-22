class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.6.4"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.4/nexttrace_darwin_amd64"
      sha256 "6db592c7fa1b88b669d52538a89678fee6281955fe12fc09197c631f9d805b12"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.4/nexttrace_darwin_arm64"
      sha256 "0ebd0e4b931ff09254b706fabb3ca88ec922bd96391de016431b64ade7345e57"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.4/nexttrace_linux_amd64"
      sha256 "2891b8b610414005d3c17c83c1fdfafc2dbe585925c34a9541a9b20c38cbfd05"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.4/nexttrace_linux_arm64"
      sha256 "bfd507c2ebf701614089853706ee2d90b956da6214a54d918baa3af4060972f1"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.6.4/nexttrace_linux_armv7"
      sha256 "c0493f81253fa4051b7d051c636f868cb3d6bdb9bfc9e377a97d144c7f04485d"
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

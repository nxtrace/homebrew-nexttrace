class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/ntr_darwin_amd64"
      sha256 "60fbb51e3b2b5f4897a9efbc669e161c18de853e4e0a238033e3e2a80b525d00"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/ntr_darwin_arm64"
      sha256 "7dcd9b340fcf0ffd71005cee0abc7b3cde2489b1df854cf4a41c07ac4dc5734d"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/ntr_linux_amd64"
      sha256 "e8cfb70dd0cde9364262e91dde5321c0d4f0d79b7d44c2982d680a6ea8a5e5f6"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/ntr_linux_arm64"
      sha256 "e4e4dda497c0f74c7eb0c9e3581030c2f93c871c863cccc37a9e71d09082fd2c"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.1/ntr_linux_armv7"
      sha256 "6dfcec9ee30aae8862a2a4cd4946a29afcf79f6ce4967bc174ce8d913bd36b14"
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

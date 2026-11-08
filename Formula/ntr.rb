class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.6"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/ntr_darwin_amd64"
      sha256 "a896892105199b07b6180472ce8087e1000b389aff5582479768409c9b0ca80e"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/ntr_darwin_arm64"
      sha256 "06c118104f61d6c057cfefe642dd955958ecc15432daeffaccd765c66db02743"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/ntr_linux_amd64"
      sha256 "454170123e90194cc29c2cc0bf98956a8b91544e1cf529a9622680744ea9f01a"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/ntr_linux_arm64"
      sha256 "63f3b3b7621503955a38c226ff1607f246eb95852d19b5b8f6ac19d1d7fa22c3"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.6/ntr_linux_armv7"
      sha256 "d8eaf3808758765b8385ce25533ed53bea4a7be2f5f43fec405fc50c16486bde"
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

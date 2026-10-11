class NexttraceTiny < Formula
  desc "Lightweight NextTrace traceroute CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.4"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace-tiny_darwin_amd64"
      sha256 "6083e70a3602d9e8acf49b31c96c2314dd3b8e335f0adbca69456090552a7e5f"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace-tiny_darwin_arm64"
      sha256 "59b587186c679167077a173b63514d9d630003ca7f91c141347a8977420cf935"
    else
      odie "Unsupported macOS architecture for nexttrace-tiny"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace-tiny_linux_amd64"
      sha256 "68b6a2210724a4b9439d9337ac69bf17fc7d662002a9a9dbdc5b96c1ab44ca26"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace-tiny_linux_arm64"
      sha256 "ce8fb581c2bd30a157aec4a38e5c0fa1c79eac3b761a978146267b6ae1c678e3"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/nexttrace-tiny_linux_armv7"
      sha256 "9b054d8575795741c9a0d79cdb499e229e7bc718f823940065bd8223ed53dbce"
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

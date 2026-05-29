class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.0"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/ntr_darwin_amd64"
      sha256 "14a0674d99f542bfa3956488d98b67d402d27518360c474d03938165b169642d"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/ntr_darwin_arm64"
      sha256 "538f430dc8066975ab0cd805c8de18a9a9d49d201e08958dc0a5e67f7f5188a0"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/ntr_linux_amd64"
      sha256 "3f60c9c5fd07b26e9d7cbf7a6d2c194ba3a89c9faa3a1093c5a8b01544e24e05"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/ntr_linux_arm64"
      sha256 "dc330965545cc175278014a0cf7a87792a9731e3ed277d3cd7648ac33913e2e6"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.0/ntr_linux_armv7"
      sha256 "1a9354e4f87d8ad97aa70c472bd9dc03c84b7fff5716026f985cf224b879c5d4"
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

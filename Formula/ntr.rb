class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.4"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/ntr_darwin_amd64"
      sha256 "b6d60a05b20e45a0901a9184dea5814d3844439e4fe15d1e4ba7ded8d386c269"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/ntr_darwin_arm64"
      sha256 "149cbf407efeec8890addff48113b9c9353efe0ddeacb2184893d3bfd8c24537"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/ntr_linux_amd64"
      sha256 "bf52ce622a8e5a0be8d785c680ef7e5e67ee00f2453d5233b6fc973e452f2d1d"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/ntr_linux_arm64"
      sha256 "56752864863275d580e1acfccab634a0bb57dbe5014d051543e0ad3454d5bf92"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.4/ntr_linux_armv7"
      sha256 "936e7dfb6c58257e74af363d0d5190d9ee5e0114a1890d5228e0c1319082086e"
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

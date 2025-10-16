class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.4.3-rc.1"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.4.3-rc.1/nexttrace_darwin_amd64"
      sha256 "447c6c3ae21a7ca73ee5a7d49369d5bf4398818c2a128424f6afd927eeb2f1c3"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.4.3-rc.1/nexttrace_darwin_arm64"
      sha256 "573456406e0545acc6a24d390083cbc68b229fc5621f99e7eee721e730238a2e"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.4.3-rc.1/nexttrace_linux_amd64"
      sha256 "a0907fd5b93fc252f75d5a645f8293cdcc439eb4c39e2a92c1e54caef1be371e"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.4.3-rc.1/nexttrace_linux_arm64"
      sha256 "0ceb4856b24a62ddfb949cb9a5f3ff4475bace3d47bcca29398a14349630380b"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.4.3-rc.1/nexttrace_linux_armv7"
      sha256 "3a2dbb4a771e3b9e4481a85c50630e74544c1057a2044d58002110ee7de342df"
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

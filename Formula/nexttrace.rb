class Nexttrace < Formula
  desc "An open source visual route tracking CLI tool"
  homepage "https://github.com/nxtrace/NTrace-V1"
  version "1.5.2-rc.0"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.0/nexttrace_darwin_amd64"
      sha256 "968048f7cafd0b0aec2fae686498f1fce38115091c0eb620fad096f3308cbc0c"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.0/nexttrace_darwin_arm64"
      sha256 "abf1c52926c871b4e6ba0807b320535744b829776452cbef9509427c15e44a7d"
    else
      odie "Unsupported macOS architecture for nexttrace"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.0/nexttrace_linux_amd64"
      sha256 "c439be4e66e1518a5c91f125cc6cbcc4cc7114fafddd459479794bcc78be12cb"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.0/nexttrace_linux_arm64"
      sha256 "31766cdb4ca49a91cf2cc94345e4d80871b3bb9662c2d95b8150490a67db8bd1"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-V1/releases/download/v1.5.2-rc.0/nexttrace_linux_armv7"
      sha256 "b7424f9cc559851d5e796fa5be0609fba7898f35483ced54373a1db028d5ffe1"
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

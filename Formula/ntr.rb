class Ntr < Formula
  desc "MTR-focused NextTrace CLI"
  homepage "https://github.com/nxtrace/NTrace-core"
  version "1.7.5"
  license "GPL-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/ntr_darwin_amd64"
      sha256 "33b4be0adc4dcc88cc9b444a445a07e7fdfaa87861971565254293b36ca64339"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/ntr_darwin_arm64"
      sha256 "bf8a7ed3f249996af235d6cbff4aa62be25cb0d584bf072f93d03b8cd4182314"
    else
      odie "Unsupported macOS architecture for ntr"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/ntr_linux_amd64"
      sha256 "76004aefe42a10ccf10c113835031414e83760d32a06850deea1e977259f88ae"
    elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/ntr_linux_arm64"
      sha256 "499eb48f09a2905c33ec2615f9ba182f407ad3508023ccdba5d1cb234855ca74"
    elsif Hardware::CPU.arm?
      url "https://github.com/nxtrace/NTrace-core/releases/download/v1.7.5/ntr_linux_armv7"
      sha256 "23518c3f70b0eac2b1ff1055f4a73de499d85f2361e42c1e2deedcc3d342ec05"
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

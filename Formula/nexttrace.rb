class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.3-beta.5"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.3-beta.5.tar.gz"
    sha256 "38e7103ddcaacaa89b284746dafa4750d5c005417558cdfc4bbdaa6758102e7b"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.3-beta.5' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

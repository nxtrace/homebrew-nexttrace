class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.2"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.2.tar.gz"
    sha256 "097c1e5d1727db160cd730a402e07fb4b2272d6872a6ae4f149cc2556fba486f"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.2' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

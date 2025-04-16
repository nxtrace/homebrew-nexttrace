class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.0"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.0.tar.gz"
    sha256 "7f620fa0dab10034cb394bcca78a7a60586b67eec1e154c1aa60fc74a3d9bc3e"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.0' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

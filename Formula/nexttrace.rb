class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.3-beta.4"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.3-beta.4.tar.gz"
    sha256 "fa8360ad0f95214e8d5b3b34740f47e4e92368a8afeb73d4b5fd36ddd0e58747"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.3-beta.4' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

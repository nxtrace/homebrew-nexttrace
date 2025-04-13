class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.3.7"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.3.7.tar.gz"
    sha256 "a5e78165208dddef9740e8bc58ef2048cb1b1eac4dbb6e0b74fd931e98458463"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.3.7' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

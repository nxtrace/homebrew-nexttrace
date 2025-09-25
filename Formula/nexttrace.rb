class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.3-beta.3"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.3-beta.3.tar.gz"
    sha256 "b6536a132a4b3f624320df5b70ff33f5ec4e8b692e26d8b283d3beb5e628ea92"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.3-beta.3' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

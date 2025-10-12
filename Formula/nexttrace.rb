class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.3-rc.1"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.3-rc.1.tar.gz"
    sha256 "d3586f399be43c81c430b35a149d94209d8191d6e5a3142beb79da6018eba195"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.3-rc.1' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.1"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.1.tar.gz"
    sha256 "c0645d8aa1444708275e311856f004ea4f3e869d4788a3d2851089c44935d6fc"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.1' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.3-beta.1"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.3-beta.1.tar.gz"
    sha256 "a35ca994839878b2502600b84134a3b90ff85b25b1609c11fcbfe692828535b2"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.3-beta.1' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

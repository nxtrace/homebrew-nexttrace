class Nexttrace < Formula
    desc "An open source visual route tracking CLI tool"
    homepage "https://github.com/nxtrace/NTrace-V1"
    version "v1.4.3-beta.2"
    url "https://github.com/nxtrace/NTrace-V1/archive/refs/tags/v1.4.3-beta.2.tar.gz"
    sha256 "46d1a9b241c0e81ca29433743db5240b398b532b95ee8a8171f08bf86632119a"
    license "GPL-3.0"

    depends_on "go" => :build
  
    def install
      system "go", "build", *std_go_args(ldflags: "-X 'github.com/nxtrace/NTrace-core/config.Version=v1.4.3-beta.2' -s -w -checklinkname=0")
    end
  
    test do
      assert_match "NextTrace", shell_output("#{bin}/nexttrace -V")
    end
  end

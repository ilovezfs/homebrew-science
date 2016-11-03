class Diamond < Formula
  desc "Accelerated BLAST compatible local sequence aligner"
  homepage "http://ab.inf.uni-tuebingen.de/software/diamond/"
  # doi "10.1038/nmeth.3176"
  # tag "bioinformatics"

  url "https://github.com/bbuchfink/diamond/archive/v0.8.25.tar.gz"
  sha256 "2542aa598e8d4f09aaad212a2d72501241c82ff6d7cd29c5be3b30cdf6b31a57"

  bottle do
    cellar :any_skip_relocation
    sha256 "db899e29c438f1002dafdb3b22811683f486b878db6cfdc0a848948ebd36cfb2" => :sierra
    sha256 "5155f5e55a77b6fa626112d3739bd56bb227ad6327cb18b84c61fc241142bee5" => :el_capitan
    sha256 "b5eca8d028b24712750fa3cd42a817bd5efa5ff64670d77e4bc07600532514bd" => :yosemite
    sha256 "cac7e089e8cd168c4347533b6a846a23e0084207f7d8c7b04e920b4edcc720f6" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "gcc" if OS.linux?

  needs :cxx11

  def install
    ENV.cxx11

    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    assert_match "gapextend", shell_output("#{bin}/diamond help 2>&1")
  end
end

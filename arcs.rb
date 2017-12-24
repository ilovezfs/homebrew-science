class Arcs < Formula
  desc "Scaffold genome sequence assemblies using 10x Genomics data"
  homepage "https://github.com/bcgsc/arcs"
  url "https://github.com/bcgsc/arcs/archive/v1.0.1.tar.gz"
  sha256 "4dc5336e741abdd0197335a21fcdc578eb4251131caf86ca4fb191c125065bf4"
  head "https://github.com/bcgsc/arcs.git"
  # tag "bioinformatics"

  bottle do
    cellar :any_skip_relocation
    sha256 "f116675834ecda922c07024db1e56c6e5603204dc21795486dbfaab9e4a81673" => :sierra
    sha256 "981dec5fe0f72a2893084e234eb786e5b1c38a67a9a14d758cb13003c532221f" => :el_capitan
    sha256 "898af980b1167279c1780f1baed5af9b567289ac1b3a1ff60440d436a914ccc7" => :yosemite
    sha256 "8c88b76af9133db18520d6d04b0b32a3cd02081bfdd78e03febcd6351cb29cb7" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "boost" => :build
  depends_on "zlib" unless OS.mac?

  def install
    inreplace "autogen.sh", "automake -a", "automake -a --foreign"
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-boost=#{Formula["boost"].opt_include}"
    system "make", "install"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/arcs --help")
  end
end

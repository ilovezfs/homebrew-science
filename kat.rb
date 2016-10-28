class Kat < Formula
  desc "K-mer Analysis Toolkit (KAT) analyses k-mer spectra"
  homepage "https://github.com/TGAC/KAT"
  url "https://github.com/TGAC/KAT/releases/download/Release-2.2.0/kat-2.2.0.tar.gz"
  sha256 "ea36dbf409900b84095ee9ee7e1bf34e105b24256eea2a45225794755e58daaf"
  # tag "bioinformatics"

  bottle do
    cellar :any
    sha256 "5978032303b587966edf2b86340039148df15681137a9da0d0958089d86bf81b" => :el_capitan
    sha256 "1d5c0781c5f127c2a5e00a903b26ab0e7c58877a41290c70f2960554b9acf49a" => :yosemite
    sha256 "0d5f2252b25b92a9443349633098c5405cd1e4d6413e6eeb79b393e61d56ccf8" => :mavericks
  end

  head do
    url "https://github.com/TGAC/KAT.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  option "with-docs", "Build documentation"

  needs :cxx11

  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "gnuplot"
  depends_on "matplotlib" => :python
  depends_on "numpy" => :python
  depends_on "scipy" => :python
  depends_on "sphinx-doc" => :python if build.with? "docs"

  def install
    ENV.cxx11

    system "./autogen.sh" if build.head?

    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"

    if build.with? "docs"
      system "make", "man"
      system "make", "html"
    end
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s,
                 shell_output("#{bin}/kat --version")
  end
end

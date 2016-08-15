class Hwloc < Formula
  desc "Portable abstraction of the hierarchical topology of modern architectures"
  homepage "http://www.open-mpi.org/projects/hwloc/"
  url "http://www.open-mpi.org/software/hwloc/v1.11/downloads/hwloc-1.11.3.tar.bz2"
  sha256 "e7748e4412fb94cf22fd1971de939d9770e6068f7003dea107417f21146333fa"

  bottle do
    cellar :any
    sha256 "e40c40f05d9ae7a0456088c0290ada2a06533f254b83a84e7cbc8de7aab3bd18" => :el_capitan
    sha256 "a2ad10c55df80a05f2e51c580aff82ec27e90613ad181f01cb23b12c3abba809" => :yosemite
    sha256 "43259277b18066df843f0f56910c2768c9be151cd0b6ca93a9a256f866eb9786" => :mavericks
  end

  head do
    url "https://github.com/open-mpi/hwloc.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  option :universal

  depends_on "pkg-config" => :build
  depends_on "cairo" => :optional

  def install
    ENV.universal_binary if build.universal?

    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--enable-shared",
                          "--prefix=#{prefix}",
                          "--without-x"
    system "make", "install"

    pkgshare.install "tests"
  end

  test do
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lhwloc",
           pkgshare/"tests/hwloc_groups.c", "-o", "test"
    system "./test"
  end
end

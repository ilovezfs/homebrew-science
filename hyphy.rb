class Hyphy < Formula
  desc "Hypothesis testing with phylogenies"
  homepage "http://www.hyphy.org/"
  url "https://github.com/veg/hyphy/archive/2.3.0.tar.gz"
  sha256 "63d5ca3a05d5995800438de49713f1e88dc2b5a7a4fffe8bfb7b94c1f582af09"
  head "https://github.com/veg/hyphy.git"

  bottle do
    sha256 "b19ac75cbe0ce6ca2eb4ebcfbe8cf9cda8f65fb230beb57eef2c8d77d75655ec" => :sierra
    sha256 "74b0628be9dddccc04b1a33c80ac25512fcc27e5f713eb51c7175a4a1a65096f" => :el_capitan
    sha256 "7a1525ce1e42fc359320dec513d9397b7d02190b9ce8bc0f892796494ca58db3" => :yosemite
  end

  option "with-opencl", "Build a version with OpenCL GPU/CPU acceleration"
  option "without-multi-threaded", "Don't build a multi-threaded version"
  option "without-single-threaded", "Don't build a single-threaded version"

  depends_on "openssl"
  depends_on "cmake" => :build
  depends_on :mpi => :optional

  fails_with :clang do
    build 77
    cause "cmake gets passed the wrong flags"
  end

  def install
    system "cmake", "-DINSTALL_PREFIX=#{prefix}", ".", *std_cmake_args
    system "make", "SP" if build.with? "single-threaded"
    system "make", "MP2" if build.with? "multi-threaded"
    system "make", "MPI" if build.with? "mpi"
    system "make", "OCL" if build.with? "opencl"
    system "make", "GTEST"

    system "make", "install"
    libexec.install "HYPHYGTEST"
    doc.install("help")
  end

  def caveats; <<-EOS.undent
    The help has been installed to #{doc}/hyphy.
    EOS
  end

  test do
    system libexec/"HYPHYGTEST"
  end
end

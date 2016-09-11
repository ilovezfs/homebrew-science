# 2.2.20 does not build on OS X. See:
# https://github.com/BIC-MNI/minc/pull/16
# https://github.com/mxcl/homebrew/issues/22152
class Minc < Formula
  desc "Medical imaging file format and toolbox"
  homepage "http://en.wikibooks.org/wiki/MINC"
  url "https://github.com/BIC-MNI/minc/archive/minc-2-1-13.tar.gz"
  version "2.1.13"
  sha256 "c1aa4889a72ac9c0b36e06d0effacc68554153b114b8f63735ee2328563b99aa"
  revision 2

  head "https://github.com/BIC-MNI/minc.git"

  bottle do
    cellar :any
    sha256 "b3a94269bb68d38e1b22aa94b944dc72d6084ccf2860a8e42521b965b41b7b4f" => :yosemite
    sha256 "ae606c8c7e993cd2b30f8977e94145b10f1fa3018313bf8e70cf7103be457226" => :mavericks
    sha256 "4d9a4ec4642955468039272c883c03fb46e3e295b6681f65188dfb5e45d091df" => :mountain_lion
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on "netcdf"
  depends_on "hdf5"

  fails_with :clang do
    # TODO: This is an easy fix, someone send it upstream!
    build 600
    cause "Throws 'non-void function 'miget_real_value_hyperslab' should return a value'"
  end

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end
end

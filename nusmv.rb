class Nusmv < Formula
  homepage "http://nusmv.fbk.eu/"
  url "http://nusmv.fbk.eu/distrib/NuSMV-2.6.0.tar.gz"
  sha256 "dba953ed6e69965a68cd4992f9cdac6c449a3d15bf60d200f704d3a02e4bbcbb"

  depends_on "wget"

  def install
    ENV.deparallelize
    system "make", "-C", "cudd-2.4.1.1", "--file=Makefile_os_x_64bit"

    cd "zchaff" do
      system "./build.sh"
      system "make", "-C", "zchaff64"
    end

    cd "nusmv" do
      system "./configure", "--enable-zchaff", "--prefix=#{prefix}"
      system "make", "install"
    end
  end
end

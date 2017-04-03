class Dotwrp < Formula
  desc "Wrapper for CBLAS *dot* functions in Accelerate framework"
  homepage "https://github.com/tenomoto/dotwrp"
  url "https://github.com/tenomoto/dotwrp/archive/v2.0.tar.gz"
  sha256 "e5dce5f75d6f941b7f0b13dcc4c140e8c90ea8f1a26dba0853d270a69a62737e"
  head "https://github.com/tenomoto/dotwrp.git"

  depends_on :fortran

  def install
    # note: fno-underscoring is vital to override the symbols in Accelerate
    system ENV.fc, ENV.fflags, "-fno-underscoring", "-c", "dotwrp.f90"
    system "ar", "-cru", "libdotwrp.a", "dotwrp.o"
    system "ranlib", "libdotwrp.a"

    lib.install "libdotwrp.a"
  end
end

class Ds9 < Formula
  desc "Astronomical imaging and data visualization"
  homepage "http://ds9.si.edu/"
  url "http://ds9.si.edu/download/source/ds9.7.5.tar.gz"
  version "7.5"
  sha256 "8ae0876472aea2d1d616595f7efcedc4ad8f5edd249721b1e4929fe317ddee3e"

  bottle do
    cellar :any_skip_relocation
    sha256 "40e75509fb3fb53f2d3a391f6b1df3971ce0878d2625a2680a053ec1e7ca3edd" => :el_capitan
    sha256 "a35573fb5f27b6e914711f1d98e7d616ebc2e27242beece1341c2d9c2f0ebca8" => :yosemite
    sha256 "211226f72b21eef4059b09fba5072adca9fe1a3cc62e5f38730134a707edfd92" => :mavericks
  end

  depends_on :macos => :lion
  depends_on :x11

  def install
    ENV.deparallelize
    # omit code signing as we do not have the signing identity
    inreplace "ds9/Makefile.unix", '$(CODESIGN) -s "SAOImage DS9" ds9', ""

    if MacOS.version == :lion
      ln_s "make.darwinlion", "make.include"
    elsif MacOS.version == :mountainlion
      ln_s "make.darwinmountainlion", "make.include"
    else
      ln_s "make.darwinmavericks", "make.include"
    end

    system "make"
    # ds9 requires the companion zip file to live in the same location as the binary
    bin.install "ds9/ds9", "ds9/ds9.zip"
  end

  test do
    system "ds9", "-analysis", "message", "'It works! Press OK to exit.'", "-exit"
  end
end

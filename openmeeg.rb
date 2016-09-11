class Openmeeg < Formula
  desc "Solves forward problems in the field of EEG and MEG"
  homepage "https://openmeeg.github.io/"
  url "https://github.com/openmeeg/openmeeg/archive/release-2.1.tar.gz"
  sha256 "fa424c59a4366d6331c76e539cf5df21bf5e0b065972b2bdda20cdb9f29aba6a"
  revision 1

  head "https://github.com/openmeeg/openmeeg.git"

  depends_on "cmake" => :build
  depends_on "hdf5"

  def install
    system "cmake", ".", "-DUSE_PROGRESSBAR=ON", *std_cmake_args
    system "make", "install"
  end
end

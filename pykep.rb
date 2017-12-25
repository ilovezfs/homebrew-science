class Pykep < Formula
  desc "Library providing basic tools for astrodynamics research"
  homepage "https://esa.github.io/pykep/"
  url "https://github.com/esa/pykep/archive/v2.1.tar.gz"
  sha256 "601a73cc6090977091ae719e692dd55cc51bde241ba2f156fb06ac1b7130feca"
  head "https://github.com/esa/pykep.git"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "boost-python"
  depends_on :python => :recommended

  def install
    args = std_cmake_args + [
      "-DBUILD_TESTS=ON",
      "-DBUILD_PYKEP=ON",
      "-DBUILD_SPICE=ON",
      "-DPYTHON_MODULES_DIR=#{lib}/python2.7/site-packages",
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    Language::Python.each_python(build) do |python, _version|
      system python, "-c", "import PyKEP"
    end
  end
end

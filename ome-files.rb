class OmeFiles < Formula
  desc "Open Microscopy Environment (OME) File scientific image I/O library"
  homepage "https://www.openmicroscopy.org/site/products/ome-files-cpp/"
  url "https://downloads.openmicroscopy.org/ome-files-cpp/0.3.0/source/ome-files-cpp-0.3.0.tar.xz"
  sha256 "1fcf2b42f5da3599b1fc78a8925f0b946a0340cbed445e2d21eddbaa1211a8a5"
  head "https://github.com/ome/ome-files-cpp.git", :branch => "develop", :shallow => false

  bottle do
    sha256 "afd2f59dfe3309bda48d878d44278531059d231421c188439b70ab0a13e961ca" => :sierra
    sha256 "365ad7ec9542ec5d1ae3571cfa55e9891012c67973e31e20d8b0f987ae0e002a" => :el_capitan
    sha256 "ea5f5ea31bb790c436ce42c435b7b746e9ac843e471acc4897e8307cb2aa0cb2" => :yosemite
  end

  option "with-api-docs", "Build API reference"
  option "without-docs", "Build man pages and manual using sphinx"
  option "without-test", "Skip build time tests (not recommended)"

  depends_on "boost"
  depends_on "cmake" => :build
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "graphicsmagick" => :optional # For unit tests only
  depends_on "ome-common"
  depends_on "ome-xml"
  depends_on "doxygen" => :build if build.with? "api-docs"
  depends_on "graphviz" => :build if build.with? "api-docs"

  # Needs clang/libc++ toolchain; mountain lion is too broken
  depends_on MinimumMacOSRequirement => :mavericks

  # Required for testing
  resource "gtest" do
    url "https://github.com/google/googletest/archive/release-1.8.0.tar.gz"
    sha256 "58a6f4277ca2bc8565222b3bbd58a177609e9c488e8a72649359ba51450db7d8"
  end

  # Required python modules for docs
  resource "Sphinx" do
    url "https://files.pythonhosted.org/packages/e3/87/e271f7f0d498c7fdaec009c27955401d18ef357c0d468e1eb2be36bdc68c/Sphinx-1.5.2.tar.gz"
    sha256 "049c48393909e4704a6ed4de76fd39c8622e165414660bfb767e981e7931c722"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/05/25/7b5484aca5d46915493f1fd4ecb63c38c333bd32aa9ad6e19da8d08895ae/docutils-0.13.1.tar.gz"
    sha256 "718c0f5fb677be0f34b781e04241c4067cbd9327b66bdd8e763201130f5175be"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz"
    sha256 "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/71/59/d7423bd5e7ddaf3a1ce299ab4490e9044e8dfd195420fc83a24de9e60726/Jinja2-2.9.5.tar.gz"
    sha256 "702a24d992f856fa8d5a7a36db6128198d0c21e1da34448ca236c42e92384825"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"
    sha256 "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"
  end

  def install
    # Set up python modules
    ENV.prepend_create_path "PYTHONPATH", buildpath/"python/lib/python2.7/site-packages"
    ENV.prepend_path "PATH", buildpath/"python/bin"
    ENV.prepend_create_path "CMAKE_PROGRAM_PATH", buildpath/"python/bin"
    resources.each do |r|
      next if r.name == "gtest"
      next if build.without?("docs")
      r.stage do
        system "python", *Language::Python.setup_install_args(buildpath/"python")
      end
    end

    if build.with? "test"
      (buildpath/"gtest-source").install resource("gtest")

      gtest_args = *std_cmake_args + [
        "-DCMAKE_INSTALL_PREFIX=#{buildpath}/gtest",
      ]

      cd "gtest-source" do
        system "cmake", ".", *gtest_args
        system "make", "install"
      end
    end

    args = *std_cmake_args + [
      "-DGTEST_ROOT=#{buildpath}/gtest",
      "-Wno-dev",
    ]

    args << ("-Ddoxygen:BOOL=" + (build.with?("api-docs") ? "ON" : "OFF"))
    args << ("-Dsphinx:BOOL=" + (build.with?("docs") ? "ON" : "OFF"))

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "ctest", "-V"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/ome-files", "--usage"
    system "#{bin}/ome-files", "info", "--usage"
  end
end

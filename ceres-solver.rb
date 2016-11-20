class CeresSolver < Formula
  desc "C++ library for large-scale optimization"
  homepage "http://ceres-solver.org/"
  revision 5

  stable do
    url "http://ceres-solver.org/ceres-solver-1.11.0.tar.gz"
    sha256 "4d666cc33296b4c5cd77bad18ffc487b3223d4bbb7d1dfb342ed9a87dc9af844"

    resource "eigen329" do
      url "https://bitbucket.org/eigen/eigen/get/3.2.9.tar.bz2"
      sha256 "4d1e036ec1ed4f4805d5c6752b76072d67538889f4003fadf2f6e00a825845ff"
    end
  end

  bottle do
    cellar :any
    sha256 "48c1879d3a5911c73b3f0e542a56ce9d7e572965c2b007efe5fdfb44725b4a91" => :sierra
    sha256 "032a6dab63945adddcd4c56f6918769560062b2d9546c0df75b069161daa1482" => :el_capitan
    sha256 "a65cbaad28b944e27ca8ce21daa73a497e1e4512208a33a97689ad0b38c0c5b6" => :yosemite
  end

  devel do
    url "http://ceres-solver.org/ceres-solver-1.12.0rc2.tar.gz"
    sha256 "eefc775896ae819a20df43c27ff8ad2a19ad197b28307a8ef165404616817ad2"

    depends_on "eigen"
  end

  head do
    url "https://ceres-solver.googlesource.com/ceres-solver.git"

    depends_on "eigen"
  end

  option "without-test", "Do not build and run the tests (not recommended)."
  deprecated_option "without-tests" => "without-test"

  depends_on "cmake" => :run
  depends_on "glog"
  depends_on "gflags"
  depends_on "suite-sparse" => :recommended
  depends_on "openblas" => :recommended if build.without?("suitesparse") && OS.linux?

  def install
    if build.stable?
      resource("eigen329").stage do
        mkdir "eigen-build" do
          args = std_cmake_args
          args << "-Dpkg_config_libdir=#{libexec}/eigen329/lib" << ".."
          args.delete("-DCMAKE_INSTALL_PREFIX=#{prefix}")
          args << "-DCMAKE_INSTALL_PREFIX=#{libexec}/eigen329"
          system "cmake", *args
          system "make", "install"
        end
        (libexec/"eigen329/share/cmake/Modules").install "cmake/FindEigen3.cmake"
      end
    end

    so = OS.mac? ? "dylib" : "so"
    cmake_args = std_cmake_args + ["-DBUILD_SHARED_LIBS=ON"]
    cmake_args << "-DMETIS_LIBRARY=#{Formula["metis"].opt_lib}/libmetis.#{so}"
    if build.stable?
      cmake_args << "-DEIGEN_INCLUDE_DIR=#{libexec}/eigen329/include/eigen3"
    else
      cmake_args << "-DEIGEN_INCLUDE_DIR=#{Formula["eigen"].opt_include}/eigen3"
    end
    cmake_args << "-DBUILD_DOCUMENTATION=ON" if build.head?
    system "cmake", ".", *cmake_args
    system "make"

    # tests are currently broken on linux:
    # https://groups.google.com/forum/#!topic/ceres-solver/S0gDJrWJcdE
    system "make", "test" if build.with?("test") && OS.mac?
    system "make", "install"
    pkgshare.install "examples"
    pkgshare.install "data"
    doc.install "docs/html"
  end

  test do
    cp pkgshare/"examples/helloworld.cc", testpath
    (testpath/"CMakeLists.txt").write <<-EOS.undent
      cmake_minimum_required(VERSION 2.8)
      project(helloworld)
      find_package(Ceres REQUIRED)
      include_directories(${CERES_INCLUDE_DIRS})
      add_executable(helloworld helloworld.cc)
      target_link_libraries(helloworld ${CERES_LIBRARIES})
    EOS

    args = ["-DCeres_DIR=#{share}/Ceres"]
    args << "-DEIGEN_INCLUDE_DIR=#{libexec}/eigen329/include/eigen3" if stable?
    system "cmake", ".", *args
    system "make"
    assert_match "CONVERGENCE", shell_output("./helloworld", 0)
  end
end

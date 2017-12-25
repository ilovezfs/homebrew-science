class Opencollada < Formula
  desc "Stream based reader and writer library for COLLADA files"
  homepage "http://www.opencollada.org"
  url "https://github.com/KhronosGroup/OpenCOLLADA/archive/v1.6.61.tar.gz"
  sha256 "c0b19d315bf7eaed5f29636ddd962ee7d3c2f7067039dba124bf9f0c94aa9e1e"

  bottle do
    cellar :any_skip_relocation
    sha256 "34252dd8c9f605f9f1ffdef4c5675820e14ccc586236f4eb095d7182dba13a55" => :sierra
    sha256 "8761610b920904e2a18b45b373fa79bcfebde96a6fb7cedb1b2b4352ccce3ffe" => :el_capitan
    sha256 "ddb1baf16fd2afb9d49a24535ed743bfef8346812cb17881c2a0950ea75d67e5" => :yosemite
    sha256 "752734452c9e55b5d0c9b5ba78560218a9150ef94d2c3046b5915ac7ea8e217d" => :x86_64_linux
  end

  depends_on "cmake" => :build
  unless OS.mac?
    depends_on "libxml2"
    depends_on "pcre"
  end

  def install
    ENV.deparallelize

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
      prefix.install "bin"
      Dir.glob("#{bin}/*.xsd") { |p| rm p }
    end
  end

  test do
    system "#{bin}/OpenCOLLADAValidator"
  end
end

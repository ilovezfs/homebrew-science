class Bcalm < Formula
  desc "de Bruijn graph compaction in low memory"
  homepage "https://github.com/GATB/bcalm"
  # doi "10.1093/bioinformatics/btw279"
  # tag "bioinformatics"

  url "https://github.com/GATB/bcalm.git",
      :tag => "v2.2.0",
      :revision => "c8ac60252fa0b2abf511f7363cff7c4342dac2ee"

  head "https://github.com/GATB/bcalm.git"

  bottle do
    sha256 "8dd755580072b0300c2c7c5fb1220c87c00f2d6c0267c9f0e435f8529c7c50d1" => :el_capitan
    sha256 "615881b3cf75e5411969cfd0aa04de7fe12c077e5945c3f5eee18e7c8ebe49b4" => :yosemite
    sha256 "f5a5a290258b96961aecbcda585cb6fffbee76791d12a566fd98b9c8d302fa93" => :mavericks
    sha256 "3959eb47b21409e0e2e9e21115bf0b0bb5552382afbe78a9b7f2791a037fcdbe" => :x86_64_linux
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      bin.install "bcalm"
    end
  end

  test do
    system bin/"bcalm"
  end
end

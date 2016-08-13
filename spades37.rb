class Spades37 < Formula
  desc "SPAdes: de novo genome assembly"
  homepage "http://bioinf.spbau.ru/spades/"
  # tag "bioinformatics"
  # doi "10.1089/cmb.2012.0021"
  url "http://spades.bioinf.spbau.ru/release3.7.1/SPAdes-3.7.1.tar.gz"
  sha256 "e904f57b08c5790c64406763b29650ffba872da47ec5a3e659396fcfcbc9b35a"

  depends_on "cmake" => :build

  needs :openmp

  fails_with :gcc => "4.7" do
    cause "Compiling SPAdes requires GCC >= 4.7 for OpenMP 3.1 support"
  end

  conflicts_with "spades", :because => "both install the spades binaries"

  def install
    mkdir "src/build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end

    # Fix audit error "Non-executables were installed to bin"
    inreplace bin/"spades_init.py" do |s|
      s.sub! /^/, "#!/usr/bin/env python\n"
    end
  end

  test do
    system bin/"spades.py", "--test"
  end
end

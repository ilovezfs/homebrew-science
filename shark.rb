class Shark < Formula
  desc "Machine leaning library"
  homepage "http://image.diku.dk/shark/"
  url "https://github.com/Shark-ML/Shark/archive/v3.1.0.tar.gz"
  sha256 "e36399b0720c69e6cb930786a8b099ac74707d71bc836a132424fa2282e368b4"

  bottle do
    cellar :any
    sha256 "6cb63ae691b9b0876ae7343ee0145c3be23354a2fcdb40a524415367e65cecaf" => :el_capitan
    sha256 "b2a62a4cadb5a226aac9742947d8a739596ea2cc3ca8945795d781743d3be7ba" => :yosemite
    sha256 "e6b8a30aa855933b744a2939eb5826d5156e4a134aaa93d2bab3ab99f4f9f681" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "homebrew/versions/boost160"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"data.csv").write <<-EOS.undent
      1 1 0
      2 2 1
    EOS

    (testpath/"test.cpp").write <<-EOS.undent
      #include <shark/Data/Csv.h>
      using namespace shark;

      int main() {
        ClassificationDataset data;
        importCSV(data, "data.csv", LAST_COLUMN, ' ');
      }
    EOS

    system ENV.cxx, "test.cpp", "-o", "test", "-L#{lib}", "-lshark",
           "-L#{Formula["boost160"].lib}", "-lboost_serialization",
           "-I#{Formula["boost160"].include}"
    system "./test"
  end
end

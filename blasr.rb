class Blasr < Formula
  desc "PacBio long read aligner"
  homepage "https://github.com/PacificBiosciences/blasr"
  # doi "10.1186/1471-2105-13-238"
  # tag "bioinformatics"
  url "https://github.com/PacificBiosciences/blasr.git",
      :tag => "smrtanalysis-4.0.0",
      :revision => "8d086d747e51a409f25481524e92e99750b14d59"
  head "https://github.com/PacificBiosciences/blasr.git"

  bottle do
    cellar :any
    sha256 "cd3242383848697bb8b2cb3e50098f34fbc3a775b0169b91145f053ed316583d" => :mountain_lion
    sha256 "6aad5177d90d352db768ebd322f357022d17c658d852051f0459d2f988b261ee" => :x86_64_linux
  end

  depends_on "hdf5"

  def install
    inreplace ["libcpp/alignment/MappingMetrics.cpp",
               "libcpp/alignment/MappingMetrics.hpp"] do |s|
      if MacOS.version >= :sierra
        s.gsub! "#ifdef __APPLE__", "#ifdef __OPPLE__"
      else
        s.gsub! "CLOCK_", "MYCLOCK_"
        s.gsub! "clockid_t", "myclockid_t"
      end
    end
    system "./configure.py", "--sub",
                             "--no-pbbam",
                             "--shared",
                             "HDF5_INCLUDE=#{Formula["hdf5"].opt_include}",
                             "HDF5_LIB=#{Formula["hdf5"].opt_lib}"
    system "make", "configure-submodule"
    system "make", "build-submodule"
    system "make"
    %w[libcpp/alignment/libblasr.dylib libcpp/pbdata/libpbdata.dylib
       libcpp/hdf/libpbihdf.dylib].each do |f|
      lib_name = Pathname.new(f).basename.to_s
      MachO::Tools.change_install_name("blasr", lib_name, "#{lib}/#{lib_name}")
      lib.install f
    end
    bin.install "blasr"
  end

  test do
    system "#{bin}/blasr"
  end
end

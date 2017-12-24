class Abinit < Formula
  desc "Atomic-scale first-principles simulation software"
  homepage "https://www.abinit.org/"
  url "https://www.abinit.org/sites/default/files/packages/abinit-8.6.3.tar.gz"
  sha256 "82e8d071088ab8dc1b3a24380e30b68c544685678314df1213180b449c84ca65"
  # tag "chemistry"
  # doi "10.1016/j.cpc.2009.07.007"

  option "with-openmp", "Enable OpenMP multithreading"
  option "without-test", "Skip build-time tests (not recommended)"
  option "with-testsuite", "Run full test suite (time consuming)"

  deprecated_option "without-check" => "without-test"

  depends_on :mpi => [:cc, :cxx, :f77, :f90]
  depends_on :fortran
  depends_on "fftw" => ["with-mpi", "with-fortran", :recommended]
  depends_on "netcdf" => :recommended
  depends_on "gsl" => :recommended
  if OS.mac?
    depends_on "veclibfort"
    depends_on "scalapack" => :recommended
  end

  needs :openmp if build.with? "openmp"

  def install
    # Environment variables CC, CXX, etc. will be ignored.
    ENV.delete "CC"
    ENV.delete "CXX"
    ENV.delete "F77"
    ENV.delete "FC"
    args = %W[
      CC=#{ENV["MPICC"]}
      CXX=#{ENV["MPICXX"]}
      F77=#{ENV["MPIF77"]}
      FC=#{ENV["MPIFC"]}
      --prefix=#{prefix}
      --enable-mpi=yes
      --with-mpi-prefix=#{HOMEBREW_PREFIX}
      --enable-optim=safe
      --enable-gw-dpc
      --with-dft-flavor=none
    ]
    args << ("--enable-openmp=" + (build.with?("openmp") ? "yes" : "no"))

    trio_flavor = "none"

    if OS.mac?
      if build.with? "scalapack"
        args << "--with-linalg-flavor=custom+scalapack"
        args << "--with-linalg-libs=-L#{Formula["veclibfort"].opt_lib} -lvecLibFort -L#{Formula["scalapack"].opt_lib} -lscalapack"
      else
        args << "--with-linalg-flavor=custom"
        args << "--with-linalg-libs=-L#{Formula["veclibfort"].opt_lib} -lvecLibFort"
      end
    else
      args << "--with-linalg-flavor=none"
    end

    if build.with? "netcdf"
      trio_flavor = "netcdf"
      args << "--with-netcdf-incs=-I#{Formula["netcdf"].opt_include}"
      args << "--with-netcdf-libs=-L#{Formula["netcdf"].opt_lib} -lnetcdff -lnetcdf"
    end

    if build.with? "gsl"
      args << "--with-math-flavor=gsl"
      args << "--with-math-incs=-I#{Formula["gsl"].opt_include}"
      args << "--with-math-libs=-L#{Formula["gsl"].opt_lib} -lgsl"
    end

    # need to link against single precision as well, see https://trac.macports.org/ticket/45617 and http://forum.abinit.org/viewtopic.php?f=3&t=2631
    if build.with? "fftw"
      args << "--with-fft-flavor=fftw3"
      args << "--with-fft-incs=-I#{Formula["fftw"].opt_include}"
      args << "--with-fft-libs=-L#{Formula["fftw"].opt_lib} -lfftw3 -lfftw3f -lfftw3_mpi -lfftw3f_mpi"
    end

    args << "--with-trio-flavor=#{trio_flavor}"

    system "./configure", *args
    system "make"

    if build.with? "test"
      cd "tests"
      if build.with? "testsuite"
        system "./runtests.py 2>&1 | tee make-check.log"
      else
        system "./runtests.py built-in fast 2>&1 | tee make-check.log"
      end
      ohai `grep ", succeeded:" "make-check.log"`.chomp
      prefix.install "make-check.log"
      cd ".."
    end

    system "make", "install"
  end

  test do
    system "#{bin}/abinit", "-b"
  end
end

class Wxmaxima < Formula
  desc "Cross platform GUI for Maxima"
  homepage "https://andrejv.github.io/wxmaxima"
  url "https://downloads.sourceforge.net/project/wxmaxima/wxMaxima/16.12.1/wxmaxima-16.12.1.tar.gz"
  sha256 "e13d4c28f7b4dd26fb29d0b9a1697622c5aa627d17cf4cc9c598d19af8acb09e"

  bottle do
    cellar :any
    sha256 "864290d79a7e640f9a8b0ad7cfc99f09ba1b621b2f8654a94aec3a732a57e43a" => :sierra
    sha256 "b963da2eb5f2140823dacc843533a5290598789c7b07010ea9064eaeb764cc02" => :el_capitan
    sha256 "0af994505af783ffa40276ce6766a786d854ed06e07af1b723c9e44f410e950a" => :yosemite
    sha256 "85493211a9129e274928159b2b82471a231ba93a9889dbdee0fd6fa8b6537f85" => :x86_64_linux
  end

  head do
    url "https://github.com/andrejv/wxmaxima.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext" => :build
  end

  depends_on "wxmac"

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    cd "locales" do
      system "make", "allmo"
    end
    system "make", "wxMaxima.app"
    prefix.install "wxMaxima.app"
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    When you start wxMaxima the first time, set the path to Maxima
    (e.g. #{HOMEBREW_PREFIX}/bin/maxima) in the Preferences.

    Enable gnuplot functionality by setting the following variables
    in ~/.maxima/maxima-init.mac:
      gnuplot_command:"#{HOMEBREW_PREFIX}/bin/gnuplot"$
      draw_command:"#{HOMEBREW_PREFIX}/bin/gnuplot"$
    EOS
  end
end

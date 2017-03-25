class Breseq < Formula
  desc "Find mutations in microbes from short reads"
  homepage "http://barricklab.org/twiki/bin/view/Lab/ToolsBacterialGenomeResequencing"
  url "https://github.com/barricklab/breseq/releases/download/v0.30.0/breseq-0.30.0-Source.tar.gz"
  sha256 "a5504a9bf7967a773ce28519ff4619c33f6b7f7efaf45ad8ed58273c5dea290d"
  head "https://github.com/barricklab/breseq.git"
  # doi "10.1007/978-1-4939-0554-6_12"
  # tag "bioinformatics"

  bottle do
    cellar :any_skip_relocation
    sha256 "780ba849d784e3ff5fd5ae0a0906c5108fd50ad30c2a257f60465633919333ee" => :el_capitan
    sha256 "c4a40aa8d7fb673a65c51627a7e48ccf4f5821e99e01001d9fe98cfd9525f763" => :yosemite
    sha256 "e4d5b3c2dc68a539c00fbae40bf7eab32131d1bf4113f3159b10c97fedd44def" => :mavericks
    sha256 "6d370e68d3cbddc76d078fb9129ebe4211cbb6b1454cce5759458bdf8e9bb873" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "bowtie2"
  depends_on "r"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "test"
    system "make", "install"
  end

  test do
    assert_match "regardless", shell_output("#{bin}/breseq -h 2>&1", 255)
  end
end

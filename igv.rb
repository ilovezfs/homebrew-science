class Igv < Formula
  desc "Interactive Genomics Viewer"
  homepage "http://www.broadinstitute.org/software/igv"
  # tag "bioinformatics"
  # doi "10.1093/bib/bbs017"
  url "http://www.broadinstitute.org/igv/projects/downloads/IGV_2.3.79.zip"
  sha256 "adc29064eea8e2576ef8a582c8489c349cbb3f4116c5f2fe92de990712de3c5b"
  head "https://github.com/broadinstitute/IGV.git"

  bottle :unneeded

  depends_on :java

  def install
    inreplace "igv.sh", /^prefix=.*/, "prefix=#{prefix}"
    prefix.install Dir["igv.sh", "*.jar"]
    bin.install_symlink prefix/"igv.sh" => "igv"
    doc.install "readme.txt"
  end

  test do
    (testpath/"script").write "exit"
    assert_match "IGV", `#{bin}/igv -b script`
  end
end

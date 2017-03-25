class Gatk < Formula
  desc "Genome Analysis Toolkit: Variant Discovery in High-Throughput Sequencing"
  homepage "https://software.broadinstitute.org/gatk/"
  url "https://github.com/broadgsa/gatk-protected/archive/3.7.tar.gz"
  sha256 "6d259a68f58b4d9954dc3c4cff2ac519e709d3e89c84fc93c459f5ba709d5551"
  head "https://github.com/broadgsa/gatk-protected.git"
  # doi "10.1101/gr.107524.110"
  # tag "bioinformatics"

  bottle :disable, "See https://github.com/Homebrew/homebrew-science/pull/4428"

  depends_on :java
  depends_on "maven" => :build

  def install
    ENV.java_cache
    system "mvn", "package"
    (share/"java").mkpath
    cp "target/GenomeAnalysisTK.jar", share/"java"
    bin.write_jar_script share/"java/GenomeAnalysisTK.jar", "gatk"
  end

  def caveats; <<-EOS.undent
    GATK Official Release Repository: contains the core MIT-licensed GATK
    framework, plus "protected" tools restricted to non-commercial use only
    EOS
  end

  test do
    assert_match "usage", shell_output("#{bin}/gatk --help 2>&1", 0)
  end
end

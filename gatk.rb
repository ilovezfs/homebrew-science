class Gatk < Formula
  desc "Genome Analysis Toolkit: Variant Discovery in High-Throughput Sequencing"
  homepage "https://software.broadinstitute.org/gatk/"
  url "https://github.com/broadgsa/gatk-protected/archive/3.8-1.tar.gz"
  version "3.8-1"
  sha256 "ae96d018ab71a83b455bffb31a60bf9f78344d7b2b6ea94b604bd26cec49f5cd"
  head "https://github.com/broadgsa/gatk-protected.git"
  # doi "10.1101/gr.107524.110"
  # tag "bioinformatics"

  depends_on :java
  depends_on "maven" => :build

  def install
    # Fix error on Circle CI.
    # Error: Could not find or load main class org.codehaus.plexus.classworlds.launcher.Launcher
    ENV.delete "M2_HOME"

    system "mvn", "package", "-Dmaven.repo.local=${PWD}/repo"
    java = share/"java"
    mkdir_p java
    cp "target/GenomeAnalysisTK.jar", java
    bin.write_jar_script java/"GenomeAnalysisTK.jar", "gatk"
    prefix.install_metafiles
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

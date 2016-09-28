class Circlator < Formula
  include Language::Python::Virtualenv

  desc "Tool to circularize genome assemblies"
  homepage "https://sanger-pathogens.github.io/circlator/"
  url "https://github.com/sanger-pathogens/circlator/archive/v1.3.1.tar.gz"
  sha256 "a360e548a1a51427c1892a997d7a9976159109c8e7fafb07743c8704fb94c6fa"
  head "https://github.com/sanger-pathogens/circlator.git"

  bottle do
    sha256 "d0a4f5960e9b0a4cc2ab208767224217616addad2e0f2b56368a52f7e410526a" => :el_capitan
    sha256 "81f736c3c6127245e144a0cd471352ac33487c7092281bce2f72a34c2c546f80" => :yosemite
    sha256 "4626b272a3f08dcdd00832358b663de3b062ee750c80403539e741b1c44406fb" => :mavericks
    sha256 "17cadae21eac200b3db265347f4d7a0698cdf38169e874ace62df71dbbb61c0f" => :x86_64_linux
  end

  # tag "bioinformatics"

  depends_on :python3
  depends_on "bwa"
  depends_on "mummer"
  depends_on "prodigal"
  depends_on "samtools"
  depends_on "spades"
  depends_on "zlib" unless OS.mac?

  resource "et_xmlfile" do
    url "https://files.pythonhosted.org/packages/22/28/a99c42aea746e18382ad9fb36f64c1c1f04216f41797f2f0fa567da11388/et_xmlfile-1.0.1.tar.gz"
    sha256 "614d9722d572f6246302c4491846d2c393c199cfa4edc9af593437691683335b"
  end

  resource "jdcal" do
    url "https://files.pythonhosted.org/packages/37/36/3199cfb80fcbf4e4df3a43647733d4f429862c6c97aeadd757613b9e6830/jdcal-1.2.tar.gz"
    sha256 "5ebedb58b95ebabd30f56abef65139c6f69ec1687cf1d2f3a7c503f9a2cdfa4d"
  end

  resource "openpyxl" do
    url "https://files.pythonhosted.org/packages/25/17/0d6096f9b2cb3e0ebb5b2fb60de016606f6dd599bec94ed524e84a1e2da8/openpyxl-2.3.5.tar.gz"
    sha256 "4307578b94a708e1519295c333c51477ac51a06f01e81b2697cc301c286a4762"
  end

  resource "pyfastaq" do
    url "https://files.pythonhosted.org/packages/2a/46/6ece19838a79489556c97092e832bafeb46e7b28c52418a6c5a7568da999/pyfastaq-3.13.0.tar.gz"
    sha256 "79bfe342e053d51efbc7a901489c62e996566b4baf0f33cde1caff3a387756af"
  end

  resource "pymummer" do
    url "https://files.pythonhosted.org/packages/8d/28/e289144751e0b33685f00a54eb5947b989348d4472a83b64a8de0b0e3f2e/pymummer-0.7.1.tar.gz"
    sha256 "7aab311c60fcb9fc5a2bce658e949d80f4801e73107eb2e835f46caed02cfedf"
  end

  resource "pysam" do
    url "https://files.pythonhosted.org/packages/27/89/bf8c44d0bfe9d0cadab062893806994c168c9f490f67370fc56d6e8ba224/pysam-0.8.4.tar.gz"
    sha256 "30cf23931edf8a426678811f234bca4a83a53438028b323f2ef55792562d9dea"
  end

  def install
    virtualenv_create(libexec, "python3")
    virtualenv_install_with_resources
  end

  test do
    output = shell_output("#{bin}/circlator test outdir")
    assert_match "Finished run on test data OK", output
  end
end

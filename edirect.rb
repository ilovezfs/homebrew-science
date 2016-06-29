class Edirect < Formula
  desc "Advanced method for accessing the NCBI's databases"
  homepage "http://www.ncbi.nlm.nih.gov/books/NBK179288/"
  url "ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/2016-06-28/edirect.tar.gz"
  version "2016-06-28"
  sha256 "cb394e73b8370c66b22c48f8725ff5516a41daad7c9f6780c9728cbf8eb69030"
  head "ftp://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/current/edirect.tar.gz"

  # tag "bioinformatics"

  bottle do
    cellar :any_skip_relocation
    sha256 "2ce62b8ffb5735b8155c701080c8e8436783b37f284544020bb28430cf4c2f55" => :el_capitan
    sha256 "ecb86895b52fa5d77aca9868a3c1a303bd86a37d701cb01cb283417ba1fb3217" => :yosemite
    sha256 "205623c6f64a0c761a10c825249a9a0db6627d5bd6f8c6b7cfc2f822bfa8c81a" => :mavericks
  end

  depends_on "go" => :run

  def install
    system "go", "build"
    libexec.install %w[setup.sh setup-deps.pl Mozilla-CA.tar.gz xtract.go]
    bin.install Dir["*"].select { |f| File.executable?(f) }
  end

  test do
    system bin/"esearch", "-help"
  end
end

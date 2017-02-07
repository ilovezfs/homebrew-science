class Poretools < Formula
  include Language::Python::Virtualenv

  desc "Tools for working with nanopore sequencing data"
  homepage "https://poretools.readthedocs.org"
  # doi "10.1093/bioinformatics/btu555"
  # tag "bioinformatics"

  url "https://github.com/arq5x/poretools/archive/v0.6.0.tar.gz"
  sha256 "64d22ac045bf4b424bd709abb07fcdb6ef4d198a76213183de166a307646b9fa"
  revision 4
  head "https://github.com/arq5x/poretools.git"

  bottle do
    sha256 "327bf557c92bb1094a2a5576c0373b3465e016cf75a7ac2d83b23a98a72704cd" => :sierra
    sha256 "78977ad070c500e052f6a94862aefe5617b289e169ad54087ecb722ff51936de" => :el_capitan
    sha256 "5b656812672a9ea86fb0b182d661f3c3ac796f85da8f9ca754bb2a4e2daf1e42" => :yosemite
  end

  depends_on "pkg-config" => :build # for h5py
  depends_on "freetype" # for matplotlib
  depends_on "hdf5"
  depends_on :fortran # for scipy
  depends_on :python if MacOS.version <= :snow_leopard

  cxxstdlib_check :skip

  resource "Cycler" do
    url "https://files.pythonhosted.org/packages/c2/4b/137dea450d6e1e3d474e1d873cd1d4f7d3beed7e0dc973b06e8e10d32488/cycler-0.10.0.tar.gz"
    sha256 "cd7b2d1018258d7247a71425e9f26463dfb444d411c39569972f4ce586b0c9d8"
  end

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/b7/67/7e2a817f9e9c773ee3995c1e15204f5d01c8da71882016cac10342ef031b/Cython-0.25.2.tar.gz"
    sha256 "f141d1f9c27a07b5a93f7dc5339472067e2d7140d1c5a9e20112a5665ca60306"
  end

  resource "functools32" do
    url "https://files.pythonhosted.org/packages/c5/60/6ac26ad05857c601308d8fb9e87fa36d0ebf889423f47c3502ef034365db/functools32-3.2.3-2.tar.gz"
    sha256 "f6253dfbe0538ad2e387bd8fdfd9293c925d63553f5813c4e587745416501e6d"
  end

  resource "h5py" do
    url "https://pypi.python.org/packages/34/57/2f8cc83bac0a2a4e44121eb13bf87e6894597ac0e765386c8ccb8cb16487/h5py-2.7.0rc2.tar.gz"
    sha256 "df785247401c695f85d21d254789792504d9d0142664307c21d0e5c538e65290"
  end

  resource "matplotlib" do
    url "https://files.pythonhosted.org/packages/79/a9/db688816150a6ef91fd9ce284c828467f7271c7dd5982753a73a8e1aaafa/matplotlib-2.0.0.tar.gz"
    sha256 "36cf0985829c1ab2b8b1dae5e2272e53ae681bf33ab8bedceed4f0565af5f813"
  end

  resource "numpy" do
    url "https://files.pythonhosted.org/packages/b7/9d/8209e555ea5eb8209855b6c9e60ea80119dab5eff5564330b35aa5dc4b2c/numpy-1.12.0.zip"
    sha256 "ff320ecfe41c6581c8981dce892fe6d7e69806459a899e294e4bf8229737b154"
  end

  resource "pandas" do
    url "https://files.pythonhosted.org/packages/08/9d/31ec596099f14528fc6ad39428248ac5360f0bb5205a3ee79a5d1cf260fb/pandas-0.19.2.tar.gz"
    sha256 "6f0f4f598c2b16746803c8bafef7c721c57e4844da752d36240c0acf97658014"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/38/bb/bf325351dd8ab6eb3c3b7c07c3978f38b2103e2ab48d59726916907cd6fb/pyparsing-2.1.10.tar.gz"
    sha256 "811c3e7b0031021137fc83e051795025fcb98674d07eb8fe922ba4de53d39188"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/51/fc/39a3fbde6864942e8bb24c93663734b74e281b984d1b8c4f95d64b0c21f6/python-dateutil-2.6.0.tar.gz"
    sha256 "62a2f8df3d66f878373fd0072eacf4ee52194ba302e00082828e0d263b0418d2"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/d0/e1/aca6ef73a7bd322a7fc73fd99631ee3454d4fc67dc2bee463e2adf6bb3d3/pytz-2016.10.tar.bz2"
    sha256 "7016b2c4fa075c564b81c37a252a5fccf60d8964aa31b7f5eae59aeb594ae02b"
  end

  resource "scipy" do
    url "https://files.pythonhosted.org/packages/22/41/b1538a75309ae4913cdbbdc8d1cc54cae6d37981d2759532c1aa37a41121/scipy-0.18.1.tar.gz"
    sha256 "8ab6e9c808bf2fb3e8576cd8cf07226d9cdc18b012c06d9708429a821ac6634e"
  end

  resource "seaborn" do
    url "https://files.pythonhosted.org/packages/ed/dc/f168ff9db34f8c03c568987b4f81603cd3df40dd8043722d526026381a91/seaborn-0.7.1.tar.gz"
    sha256 "fa274344b1ee72f723bab751c40a5c671801d47a29ee9b5e69fcf63a18ce5c5d"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  resource "subprocess32" do
    url "https://files.pythonhosted.org/packages/b8/2f/49e53b0d0e94611a2dc624a1ad24d41b6d94d0f1b0a078443407ea2214c2/subprocess32-3.2.7.tar.gz"
    sha256 "1e450a4a4c53bf197ad6402c564b9f7a53539385918ef8f12bdf430a61036590"
  end

  resource "test" do
    url "ftp://ftp.sra.ebi.ac.uk/vol1/ERA412/ERA412821/oxfordnanopore_native/MVA_filtered.tar.gz"
    sha256 "76b00286acba1f65c76a3869bc60e099190ce48d0a5822606ce222e80529e523"
  end

  def resources
    front_load = [resource("six"), resource("numpy")]
    front_load + (super - front_load - [resource("Cython"), resource("test")])
  end

  def install
    ENV.delete("SDKROOT")
    ENV["HDF5_DIR"] = Formula["hdf5"].opt_prefix

    resource("Cython").stage do
      system "python", *Language::Python.setup_install_args(buildpath/"cython")
    end

    ENV.prepend_create_path "PATH", buildpath/"cython/bin"
    ENV.prepend_create_path "PYTHONPATH", buildpath/"cython/lib/python2.7/site-packages"

    virtualenv_install_with_resources

    (pkgshare/"test_data").install resource("test")
  end

  test do
    result = <<-EOS.undent
      total reads	297
      total base pairs	260131
      mean	875.86
      median	795
      min	325
      max	3602
      N25	965
      N50	830
      N75	741
    EOS
    output = shell_output("#{bin}/poretools stats #{pkgshare}/test_data")
    assert_equal result, output
  end
end

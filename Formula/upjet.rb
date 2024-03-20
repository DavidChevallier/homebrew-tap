class Upjet < Formula
    desc "Upjet: A code generation framework and runtime for Crossplane providers"
    homepage "https://github.com/crossplane/upjet"
    url "https://github.com/crossplane/upjet/archive/refs/tags/v1.1.0.tar.gz"
    sha256 "c9d40ddb9a7bcff084210d25ffc5381b1e8ec01b711f323568b48295691fda4f"
    depends_on "go" => :build

    def install
      system "git", "submodule", "update", "--init", "--recursive"
      ENV["GO111MODULE"] = "on"
      system "make", "build"
      bin.install "upjet"
    end

    test do
      system "#{bin}/upjet", "--version"
    end
  end

class Upjet < Formula
    desc "Upjet: A code generation framework and runtime for Crossplane providers"
    homepage "https://github.com/crossplane/upjet"
    url "https://github.com/crossplane/upjet/archive/refs/tags/v1.1.0.tar.gz"
    sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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

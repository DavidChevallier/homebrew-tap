class Terraform < Formula
    desc "Tool to build, change, and version infrastructure"
    homepage "https://www.terraform.io/"
    url "https://releases.hashicorp.com/terraform/1.8.2/terraform_1.8.2_darwin_amd64.zip"
    sha256 "a71ada335aba64ac1851ffbb2cf8f727a06013d02474dd70c4571f585b1fe522"
    license "MPL-2.0"
    head "https://github.com/hashicorp/terraform.git", branch: "main"
  
    conflicts_with "tfenv", because: "tfenv symlinks terraform binaries"
  
    def install
      bin.install "terraform"
    end
  
    test do
      minimal = testpath/"minimal.tf"
      minimal.write <<~EOS
        variable "aws_region" {
          default = "us-west-2"
        }
  
        variable "aws_amis" {
          default = {
            eu-west-1 = "ami-b1cf19c6"
            us-east-1 = "ami-de7ab6b6"
            us-west-1 = "ami-3f75767a"
            us-west-2 = "ami-21f78e11"
          }
        }
  
        # Specify the provider and access details
        provider "aws" {
          access_key = "this_is_a_fake_access"
          secret_key = "this_is_a_fake_secret"
          region     = var.aws_region
        }
  
        resource "aws_instance" "web" {
          instance_type = "m1.small"
          ami           = var.aws_amis[var.aws_region]
          count         = 4
        }
      EOS
      system "#{bin}/terraform", "init"
      system "#{bin}/terraform", "graph"
    end
  end
  
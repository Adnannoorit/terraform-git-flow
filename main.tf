provider "aws" {
  region  = "us-west-2"
}

terraform {
    backend "s3" {
        bucket = "cloudacademylabs-terraformstates3bucket-y2ro1wywkb55"
        encrypt = true
        key = "path/to/state/state.tfstate" # Where you want to store state in S3
    region  = "us-west-2"
            }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = "subnet-0a82995f2b984a433" 

  tags = {
    Name = "HelloWorld"
  }
 }

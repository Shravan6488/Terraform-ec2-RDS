provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
resource "aws_key_pair" "terraform-keys2" {
  key_name = "terraform-keys2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7z9GejkffHnVEIXIyR0lYP4etoJq4AzRQIAyY1+hLjOW7H9P//xddbJasiFtH3uuz6DF8eEDYRpyRXm+IdlJHiPbtCc9YAZGLqXLxkRrxU5fJZwdrjPKaII9wx1I3coPVe++ag2EO8Kq2+FYFKN0I+4wy/7Jni3tBeyPLWxQfdBITvK14tefoQ7+AQ8MO8uLGB7zs2xZRlG8ETjISW6fZqJjVs7pF2EXslnwY5e+yWzfBiYEc7WeL3KD4bs27D77WhzmwSBeRcPSZzWoPPXbsCT571NiiUaxyGyIe70jZ47lx39OlAp61I/GYi/mR5aD8eK1laDcl0SPr2GbcDKzR sravan@Sravans-MBP-2"
}
// access policy (ec2 ro)
data "aws_iam_policy_document" "param_store_policy_ro" {
  statement {
    actions = [
      "kms:Decrypt",
      "ssm:GetParameterHistory",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
    ]

    resources = [
      "arn:aws:ssm:${var.region}:${var.account_id}:parameter/global/*",
    ]
  }
}

// join access policy document to policy for ro
resource "aws_iam_policy" "param_store_policy_ro" {
  name   = "${var.environment}-${var.region}-parameter-store-policy-ro"
  policy = "${data.aws_iam_policy_document.param_store_policy_ro.json}"
}
resource "aws_instance" "instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_public_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = aws_key_pair.terraform-keys2.key_name
    root_block_device {    
    volume_size = 20    
    volume_type = "standard"  
    }
  tags = {
		"Environment" = var.environment_tag
    "Name" = "web" 
    }
    provisioner "remote-exec" {
         inline = ["sudo yum -y update",
                  "sudo amazon-linux-extras enable postgresql10",
                  "sudo yum install -y php-mysql php php-xml php-mcrypt php-mbstring php-cli mysql php-pgsql.x86_64",
                   "sudo yum install -y postgresql",
            ]
         connection {
                  type        = "ssh"
                  host        =  self.public_ip
                  user        = "ec2-user"
                  private_key = "${file(var.key_name)}"
              }
         } 
  #local-exec runs our app server related playbook
#   provisioner "local-exec" {
 #      command ="ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${self.public_ip}, ../ansible/playbook.yml --private-key=./modules/keys/terraform-keys2 -u ec2-user"
    
 #      }
}
resource "aws_eip" "testInstanceEip" {
  vpc       = true
  instance  = aws_instance.instance.id

  tags = {
    "Environment" = var.environment_tag
  }
}


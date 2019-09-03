# Static website Setup using Terraform and Ansible

In this project, we are creating a instance with webserver and RDS postgresql And deployment setup with ansible.

## Prerequisites

Terraform ~> 0.12

First needs to run terraform with aws access key and secury key.( root path variable.tf)

I have used eu-central-1 for Region and the variables are configured for this region only ( this can be changed in variable.tf file)

Change the path to your current local path for keys ( path = module/instance/variable.tf (variable "key_name"))

Terraform commands:

terraform init
 
terraform plan

terraform apply


Then run ansible to provision webserver servers.
Before running ansible please change the password for the DB in index.php file ( path ansible/files/index.php)
- You can find the DB password in AWS parameter store
- And also Change the db hostname accordingly

Ansible command: "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i {public_ip}, .{path}/ansible/playbook.yml --private-key={path}/modules/keys/terraform-keys2 -u ec2-user"

## Cleanup

terraform destroy
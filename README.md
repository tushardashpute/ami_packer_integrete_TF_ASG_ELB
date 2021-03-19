# ami_packer_integrete_TF_ASG_ELB

To create the AMI using packer use below 3 files.

ebs.json
setup.sh
welcomefile

## Flow link https://www.middlewareinventory.com/blog/packer-aws-terraform-example/
packer validate ebs.json 
packer build ebs.json 


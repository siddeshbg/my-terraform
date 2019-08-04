# my-terraform

A quick bootstrap guide to Terraform

## Installation (in Mac)
```brew install terraform```

## Commands
* ```terraform init```
    * Need to run it for the 1st time. It downloads the defined provider plugins
* ```terraform plan```
    * ```terraform plan -out tf.out```
* ```terraform apply```
    * ```terraform apply tf.out```
* ```terraform destroy```

## Creating AWS EC2 instance

### Simple way
Copy the below code snippet into a file ex. create-ec2-instance.tf

```create-ec2-instance.tf
provider "aws" {
  region     = "ap-southeast-1" # Replace it with ur region
  access_key = "***********"  # Replace it with your access key
  secret_key = "***********"  # Replace it with your secret key
}

resource "aws_instance" "siddesh-tf-tmp1" { # Provide a suitable instance name
  ami           = "ami-01f7527546b557442" # Replace it with ami image id specific to ur region
  instance_type = "t2.micro"

  tags = {
    Name = "siddesh-temp" # provide a suitable tag
  }
  subnet_id = "******" # It is requird if there is no default VPC
}
``` 
Run the command
* ```terraform plan```

and then

* ```terraform apply```

and this should create an EC2 instance

### Professional way
Refer the contents of `create-ec2-instance` folder. 
* The `provider.tf` file defines the AWS provider with it's keys and region
    * This file refers variables defined in `vars.tf`
* The `instance.tf` file defines the EC2 instance resource by declaring AMI image details, instance type etc
    * The `subnet_id` defined in this file is optional. I need to define it coz there was no default VPC defined in my
    AWS account
* The `vars.tf` file defines all the variables.
    * No values are providef for the `AWS_ACCESS_KEY` and `AWS_SECRET_KEY`. Since these values are confidential, it is
    defined in another file `terraform.tfvars`, which is not version controlled.
* Create a file by name `terraform.tfvars` and define ur confidential values there. 
**Don't ever checkin this file to version control***

Ex. vi terraform.tfvars
```terraform.tfvars
AWS_ACCESS_KEY = "*******"
AWS_SECRET_KEY = "********"
AWS_SUBNET = "*******"

```


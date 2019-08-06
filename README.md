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
    * ```terraform destroy -target aws_instance.siddesh-temp```

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
    * **Don't ever checkin this file to version control***
    * add `*/terraform.tfvars` to .gitignore file to avoid checking into Git

Ex. vi terraform.tfvars
```terraform.tfvars
AWS_ACCESS_KEY = "*******"
AWS_SECRET_KEY = "********"
AWS_SUBNET = "*******"

```

## Provisioning software on EC2 instance
Refer the contents of `provision-ec2-instance` folder. In this example an EC2 instance is created and then nginx is
installed on it using `file` and `remote-exec` provisioners 
* The new changes in `instance.tf` file are
     * a new resource `aws_key_pair` is added, which will register public key with AWS to allow logging-in to EC2 
     instances. 
     * But before that you need to create this ssh pub and private key with command 
     
        ```ssh-keygen -f mykey```
        * Run this command under `provision-ec2-instance` folder and this will generate files `mykey` and `mykey.pub`
     * The code to resource `aws_key_pair` is
     
         ```aidl
        resource "aws_key_pair" "siddesh-key" {
          key_name = "mykey"
          public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
        }
        ```
    
        * This will register public key (i.e `mykey.pub` from the path `${var.PATH_TO_PUBLIC_KEY}` which is defined in 
        vars.tf) with AWS   
        
     * Then in the `aws_instance` resource, we are associating this key name with EC2 instance
     ```key_name = "${aws_key_pair.siddesh-key.key_name}"``` 
     * The `file` provisioner copies the file `script.sh` to EC2 instance, which contains instructions to download and 
     install nginx
     * The `remote-exec` provisioner runs this script
     * The `connection` block contains details to connect to this EC2 instance for running this script
        ```aidl
        connection {
            host = coalesce(self.public_ip, self.private_ip)
            type = "ssh"
            user = "${var.INSTANCE_USERNAME}"
            private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
          }
        ```
        * The `coalesce` function returns the first non-empty string from the list i.e either public / private ip
        * Since the connection type is ssh, it needs user and path to ssh private key
 


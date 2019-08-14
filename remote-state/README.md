## Prerequisites
- create s3 bucket
    - ex. I created a bucket by name `siddesh-tf-state`
- aws configure
    - configure your access key, secret key and region where s3 bucket is located

## Execution
- run `terraform init`
    -   it will configure s3 as backend
- run `terraform apply`
    - this will store terraform state files in s3 bucket


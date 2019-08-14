## Preparation
### Generating ssh keys
- in this directory run the command `ssh-keygen -m PEM -t rsa -f mykey` 
    - note that, in recent versions of Mac, the ssh-keygen command generates openssh private key by default
    - but AWS requires the RSA private key
    - the options `-m PEM -t rsa` ensures it generates RSA private key
- This command generates `mykey` and `mykey.pub` in the current directory

### know ur machine public IP
- Google search whatsmyip

### Add your pub key to your AWS default security group
- Browse to `default` security group -> Edit -> Add Rule -> Type:'All TCP' Protocol:TCP PortRange:0-65535 
  Source:Custom <x.x.x.x>/32

## Provisioning
- Next run ```terraform apply```

## Connecting to Windows machine
### Install Microsoft Remote Desktop
- You can get it in Mac App store

### Get the Administrator password for your new EC2 instance
- You can get using CLI
```aws ec2 get-password-data --instance-id <instance-id> --priv-launch-key mykey```
    - You can find the instance-id if you login to AWS console and then by selecting your newly created windows EC2 
    instance
- You can also get password from AWS console
    - Select EC2 instance ->  Actions -> Get Windows Password -> Copy paste the content of ssh private key file `mykey`
    
### Login to Windows EC2 instance
- Login to your newly created windows EC2 instance using `Microsoft Remote Desktop` with username Administrator and 
with the password obtained in previous step
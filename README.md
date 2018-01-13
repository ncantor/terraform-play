# Terraform Play

Basic terraform project to create an Ubuntu 16.04 server, and add some simple configuration. Built on AWS. This configuration creates a simple firewall entry to allow SSH access, and a custom MOTD. It's hosted in Sydney.

Original Ask
```
Create an Ubuntu 16.04 server
Enable SSH login
Disable password-based login & ensure key access is enabled
Configure the firewall to allow ssh port access on the standard SSH port
Change the MOTD to say "Hello Assurity DevOps"
```
The default AWS Ubuntu 16.04 image enables key-only SSH login (password login is disabled)


## Getting Started

These instructions will get you a copy of the project, which you can then use to configure AWS.

### Prerequisites

You'll need to have the following to make this project work

```
terraform
an ssh key pair
an AWS ec2 account
exported AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY configured (or the IAM equivalents)
```

### Do it

Export the public SSH key you want to use

```
export TF_VAR_PUBLIC_SSH_KEY=<YOUR PUBLIC KEY>
```

Go the the terraform directory for this project

```
cd terraform
```

Check what the application will do

```
terraform plan
```

Build the server

```
terraform apply
```

The last line of output from apply will be the public DNS entry for the new server.
Connect to the server as the ubuntu user, either by SSHing to the dns name you were given, or in this unnecessarily fancy way.

```
ssh ubuntu@`terraform output |awk '{print $3}'`
```

The last line of the MOTD should be "Hello Assurity DevOps"

### Additional Options

This solution used the most direct method of satisfying requirements. There are other ways to solve this, and similar challenges.

## Option 1

In a more complicated setup, we could have added variables to allow people to specify the region they want to connect to, and pull the AMI automatically.

## Option 2

Use a template, instead of a script, for the MOTD

## Option 3

Use a static file for the MOTD, and simply copy it from the executing system to the remote system

## Option 4

In a more complicated environment, puppet, ansible, or AWS Config could be used to ensure that the MOTD change is correct, and that anything else which needs to be done is also done. As a single step process, it's easier to validate manually than to add a test framework to ensure that everything works.

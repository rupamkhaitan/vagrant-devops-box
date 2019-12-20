# DevOps box
* A vagrant project with an ubuntu box with the tools needed to do DevOps.
    - Install Oracle Virtual Box (https://www.virtualbox.org/wiki/Downloads)
    - Install Vagrant (https://www.vagrantup.com/downloads.html)
    - Install Vagrant Plugin
      - `vagrant plugin install vagrant-disksize`
      - `vagrant plugin install vagrant-env`

## Tools included
* The following tools are included if you want to change any version edit the `.env` file
  - Git & Git LFS
  - Terraform
  - AWS CLI
  - Docker
  - Packer
  - JQ
---


Typing `vagrant` from the command line will display a list of all available commands. [See More](docs/commands.md)


## Setting up VM
1. Install VM by running below command
  ```bash
    vagrant up
  ```

  - *Note*: [Windows Disable Hyper-V](docs/windows.md)

  - *Note*: [Ignore Warning](docs/install_warning_.md) when running `vagrant up`


2. SSH into the VM
  ```bash
    vagrant ssh
  ```

## Get an AWS Access Key and Secret Access Key

* Log into your AWS account: https://console.aws.amazon.com/
    - Navigate to your IAM Account Page
      - Services -> IAM
      - Click on Users
      - Double click on your account when the list pops up
      - Scroll down to the 'Create Access Key" button
        - Click the button and save the two keys

* Create your AWS Prod profile
  - Run the below command inside your VM machine created using vagrant
  
  ```bash
  aws configure --profile prod
  ```
    - Enter access key
    - Enter secret access key
    - Enter default region: us-east-1
    - Default output format: json
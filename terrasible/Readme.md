# Installing and Configuring Jenkins using Ansible and Terraform


Terraform is a tool for building infrastructure safely and efficiently. Ansible is a simple serverless configuration management tool. In this use case we create an instance in AWS EC2 with Terraform, further install and configure Jenkins using Ansible playbooks, which is invoked from Terraform.

**The Terraform specifications for the EC2 instance creation are:**

 •	Region name

 •	Access-key & Secret-key

 •	Instance image ID (ami) from the particular region

 •	Subnet ID

 •	Security Group ID – where the ports are open

 •	Key pair name and its path to access 

##### Note: Terraform & Ansible is installed on the local machine.

In the local machine, **demo.tf** terraform file is created, where the provider and the resource parameters are defined to create the AWS EC2 instance. The local-exec command in demo.tf file, sleeps for the 120s and sets the **ANSIBLE_HOST_KEY_CHECKING** environment variable to false to connect to the newly-launched instance. Then runs the **ansible-playbook** command, with the user name, private key, instance public IP.

    provider "aws" {
      region     = "us-west-2"
      access_key = "AKIAW2NVC4LCWZ7ZFIGF"
      secret_key = "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"
    }

    resource "aws_instance" "jenkins-demo" {
        ami = "ami-003634241a8fcdec0"
        instance_type = "t2.micro"
        tags = {
            Name = "jenkins-demo"
        }
        subnet_id = "subnet-71977909"
        security_groups = ["sg-370d906e"]
        associate_public_ip_address = true
        key_name = "new-key"

         provisioner "remote-exec" {
         inline = [
           "sudo apt-get update",
           "sudo apt-get install python default-jre -y"
         ]
        connection {
         type = "ssh"
         host = self.public_ip
         user = "ubuntu"
         private_key = file("./new-key.pem")
       }
    }
        provisioner "local-exec" {
            command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ./new-key.pem -i '${aws_instance.jenkins-demo.public_ip},' demo.yaml"
        }
    }

 
The Ansible playbook demo.yaml has tasks defined for the installation of Jenkins. With both the files in the same directory, initialize and apply terraform.

    - hosts: all
      become: true

      tasks:
        - name: ensure the jenkins apt repository key is installed
          apt_key: url=https://pkg.jenkins.io/debian-stable/jenkins.io.key state=present

        - name: ensure the repository is configured
          apt_repository: repo='deb https://pkg.jenkins.io/debian-stable binary/' state=present

        - name: ensure jenkins is installed
          apt: name=jenkins update_cache=yes

        - name: ensure jenkins is running
          service: name=jenkins state=started

 
### Execution Steps:
 •	Initialize the Terraform plugins (AWS)
 
    terraform init
 
 •	Validate the Terraform file (.tf).
 
    terraform validate
    
 •	Launch the EC2 instance creation. 
 
    terraform apply

 •	The EC2 instance is creating and connecting to the host.
 
 
           + root_block_device {
               + delete_on_termination = (known after apply)
               + device_name           = (known after apply)
               + encrypted             = (known after apply)
               + iops                  = (known after apply)
               + kms_key_id            = (known after apply)
               + volume_id             = (known after apply)
               + volume_size           = (known after apply)
               + volume_type           = (known after apply)
             }
         }

     Plan: 1 to add, 0 to change, 0 to destroy.

     Do you want to perform these actions?
       Terraform will perform the actions described above.
       Only 'yes' will be accepted to approve.

       Enter a value: yes

     aws_instance.jenkins-demo: Creating...
     aws_instance.jenkins-demo: Still creating... [10s elapsed]
     aws_instance.jenkins-demo: Still creating... [20s elapsed]

 
 •	The installation of Jenkins in the EC2 instance is successful.
 

    aws_instance.jenkins-demo (local-exec): TASK [ensure jenkins is installed] *********************************************
    aws_instance.jenkins-demo: Still creating... [3m50s elapsed]
    aws_instance.jenkins-demo: Still creating... [4m0s elapsed]
    aws_instance.jenkins-demo: Still creating... [4m10s elapsed]
    aws_instance.jenkins-demo: Still creating... [4m20s elapsed]
    aws_instance.jenkins-demo: Still creating... [4m30s elapsed]
    aws_instance.jenkins-demo: Still creating... [4m40s elapsed]
    aws_instance.jenkins-demo (local-exec): changed: [34.219.65.240]

    aws_instance.jenkins-demo (local-exec): TASK [ensure jenkins is running] ***********************************************
    aws_instance.jenkins-demo (local-exec): ok: [34.219.65.240]

    aws_instance.jenkins-demo (local-exec): PLAY RECAP *********************************************************************
    aws_instance.jenkins-demo (local-exec): 34.219.65.240              : ok=5    changed=3    unreachable=0    failed=0

    aws_instance.jenkins-demo: Creation complete after 4m41s [id=i-0cdeddb11d0f1b122]

    Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

 
 •	To verify the installation and configuration, Using a browser from local machine access the Public IP address of the instance with the port 8080 to connect to the Jenkins.
 
  
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output1.png)
 
 
 •	On Successful connection, it leads to the Jenkins Home page.  
 
  ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 


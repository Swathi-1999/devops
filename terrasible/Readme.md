                           Installing and Configuring Jenkins using Ansible and Terraform


Terraform is a tool for building infrastructure safely and efficiently. Ansible is a simple serverless configuration management tool. In this use case we create an instance in AWS EC2 with Terraform, further install and configure Jenkins using Ansible playbooks, which is invoked from Terraform.
The Terraform specifications for the EC2 instance creation are:
•	Region name
•	Access-key & Secret-key
•	Instance image ID (ami) from the particular region
•	Subnet ID
•	Security Group ID – where the ports are open
•	Key pair name and its path to access 

Note: Terraform & Ansible is installed on the local machine.
In the local machine, demo.tf terraform file is created, where the provider and the resource parameters are defined to create the AWS EC2 instance. The local-exec command in demo.tf file, sleeps for the 120s and sets the ANSIBLE_HOST_KEY_CHECKING environment variable to false to connect to the newly-launched instance. Then runs the ansible-playbook command, with the user name, private key, instance public IP.
 
The Ansible playbook demo.yaml has tasks defined for the installation of Jenkins. With both the files in the same directory, initialize and apply terraform.
 
      Execution Steps:
•	Initialize the Terraform plugins (AWS)
terraform init
•	Validate the Terraform file (.tf).
 
•	Launch the EC2 instance creation.
terraform apply
•	The EC2 instance is creating and connecting to the host.
 
•	The installation of Jenkins in the EC2 instance is successful.
 
•	To verify the installation and configuration, Using a browser from local machine access the Public IP address of the instance with the port 8080 to connect to the Jenkins.
 
•	On Successful connection, it leads to the Jenkins Home page.  


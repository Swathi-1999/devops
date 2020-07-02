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


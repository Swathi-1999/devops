# Deploying Docker Container with Jenkins Pipeline Using GitHub

To deploy a Docker container with Jenkins, create a EC2 instances and install the Jenkins. Further connect to this EC2 instance terminal and install Docker. And then add the Docker pipeline plugin to the Jenkins. Create the Job to connect to the GitHub repository by providing the URL where the **Jenkinsfile** is written in the Groovy script. On successful creation of the Jenkins pipeline job for Docker, build the job and verify the Console output.

**Steps to Deploy the Docker Container with Jenkins Pipeline using GitHub repository are:**

1.	Create a EC2 instance in AWS console and install the Jenkins.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/1.jpg)
 
2.	Connect to Jenkins dashboard with your user credentials.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/2.jpg)
 

3.	Install Docker on the Linux instance where the Jenkins is installed.

    a.	Open the Linux instance terminal and install the Docker in the Linux instance as shown below.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/3a-1.jpg)
      
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/3a-2.jpg)
  

    b.	Run the Docker command to start the Docker and check its status.
      
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/3b.jpg)
 

    c.	Provide the permission to the **docker.sock** file and restart the Docker.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/3c.jpg)
 

4.	Install Docker Pipeline plugin on the Linux instance.
    a.	Navigate to **Manage Jenkins** and select **Manage Plugins** under System Configuration as shown below.
       
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/4a.jpg)

    b.	Select **Available** and search for **Docker Pipeline plugin**. Select the check box of the Docker Pipeline plugin and click **Install without restart**.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/4b.jpg)
   
    c.	The installation process will proceed and Success message will be displayed.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/4c.jpg)
 


5.	Create a Docker Pipeline Job on Jenkins instance using the GitHub repository.

    a.	Open the GitHub repository were the required **Jenkinsfile** is present.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/5a.jpg)
 

    b.	Navigate to **Code** and copy the **HTTPS** link for the GitHub repository as given below.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/5b.jpg)
 

    c.	Open the Jenkins Dashboard, navigate to main menu and select New Item to create a Docker CI Pipeline Job.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/5c.jpg)
 

    d.	Provide the name for the job, select Pipeline and click OK.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/5db.jpg)
 

    e.	Navigate to Pipeline and select Pipeline Script from SCM under Definition. Under SCM select Git and paste the Git Repository URL of the GitHub as shown below.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/5e.jpg)
 

    f.	Provide the Branch Specifier and click Save.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/5f.jpg)
      
 
6.	Build the Docker-CI-Pipeline job.

    a.	Job is created successfully, click Build Now to execute the pipeline. Click on build created under Build History as shown below.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/6a.jpg)
 
    b.	On successful execution of all the pipeline stages finally the SUCCESS message is displayed as shown below.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/6b-1.jpg)
      
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/DockerContainer_JenkinsPipeline_using_GitHub/JPG_images/6b-2.jpg)
 
 





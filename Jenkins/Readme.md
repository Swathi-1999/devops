# CI/CD of Java Application from GitHub using Jenkins Pipeline Scripts and Webhooks 

This POC illustrates on how to build a Java application from GitHub repository by using Jenkins pipeline scripts and update the changes using Webhooks
The following are the steps to build a Java application from GitHub repository using Jenkins Scripted Pipeline and to create Webhook:
1.	Create an Instance in AWS, download and install JDK in it.
2.	Download and install Jenkins in the same Instance and run Jenkins on port 8080.
3.	Provide the Credentials by navigating to the path using Jenkins browser.
4.	Install suggested plugins and get started with Jenkins by creating the user.
5.	Create Job by choosing pipeline.
 
   ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Jenkins/Pipeline.jpg)

6.	Write the pipeline script to integrate Jenkins with GitHub and Maven to build Java application.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Jenkins/PipelineScript.jpg)
  
  a.	Generate the Pipeline Syntax for Git credentials, URL of GitHub repository and Maven, by following the Pipeline Syntax Link.
    
  b.	Use the Pipeline syntax generated values in the Pipeline script.
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Jenkins/PipelineScript.jpg)
     
7.	To build the Application, use Build Now option in Jenkins and verify in the console that the application with .war file is built successfully
 



8.	Add the URL of GitHub repository and check GitHub hook trigger for polling in Configure page
 
9.	In the GitHub repository, create Webhooks by providing the URL of Jenkins in “Payload URL” textbox.
 

10.	Create README.md file with some sample text in it and Commit changes or update any files in GitHub repository
 

11.	Navigate and verify the updates of the Application.
 


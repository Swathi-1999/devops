# Git Versioning in Private Repository

This POC illustrates how to track the changes of source code present in GitHub private repository.

The following are the steps to control the version of source code in GitHub Private repository:
1.	Create a Private Repository in GitHub account and copy the URL of Private repository for further use.
2.	Create an Instance in AWS and connect with the instance by providing the SSH command.
3.	Create a Linux user account in using Linux command.
4.	Push the application file into the GitHub private repository.
    
    a.	Create an authorized key for authenticating the user in the terminal by adding the SSH public key.
            ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/SSH_key.jpg)
            
    b.	Initialize an empty git repository in an Instance by using git command.
            ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Initialize.jpg)
            
    c.	Create a file as simple.html and paste the source code in the file.
            ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Simple_file1.jpg)
            
    d.	Commit the code by providing the message which is displayed in the GitHub repository.
    
    e.	Add the remote to the Private Repository using git command by providing the Repository alias name and Private repository URL.
            ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Remote.jpg) 
    
    f.	Push the code to GitHub private repository by using git command with the alias name.
            ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Push_File1.jpg) 

5.	Verify the file is uploaded in GitHub account by reloading the page.
    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Repo_firstcommit.jpg) 

6.	Modify the file, add the remote and push the file to GitHub private repository

7.	Verify the updated version of a source code that is pushed in the GitHub repository.
    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Repo_secondcommit.jpg) 

8.	Click History to copy the commit ID of the previous version of application in GitHub repository.
    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Repo_history.jpg) 

9.	Download the older versions of the application from the GitHub private repository.
    
    a.	Paste the commit ID of simple.html file and run checkout command.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Checkout.jpg) 
      

    b.	Download the simple.html file older version into the instance using git push command.
         
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Push_File2.jpg) 
      
        
    c.	Verify the simple.html older file as shown below.
         
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GitVersioning/Simple_File2.jpg) 
      

# Installation of YUM on UBUNTU Instance

The YUM is a package management utility for Red Hat based systems such as RHEL or CentOS. It is mainly used to manage RPM packages. Ubuntu has its own package management system. The equivalent tool for Ubuntu is apt, this is used to install or manage packages on Ubuntu.

**Steps to install YUM on UBUNTU instance, they are:**

1.	First update the apt package manager.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 

2.	To install yum and other tools for the creation of a repo, install the yum-utils using apt.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 

3.	Test the yum. The result is that it doesn’t have repositories configured, so when you list all the yum repositories it will not be able to find any packages to list as shown below.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 

4.	Create a test repository as show below as sudo user.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 

5.	Provide the repository definition as shown.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 

6.	Enable the test repository defined using the below command.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 

7.	After the enable is successful, test the repository by installing the nginx package as shown.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
 

8.	Now, list all the packages in yum repository with the below command.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/terrasible/output2.png)
    
 



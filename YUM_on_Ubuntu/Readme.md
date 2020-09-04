# Installation of YUM on UBUNTU Instance


The YUM is a package management utility for Red Hat based systems such as RHEL or CentOS. It is mainly used to manage RPM packages. Ubuntu has its own package management system. The equivalent tool for Ubuntu is apt, this is used to install or manage packages on Ubuntu.


**Steps to install YUM on UBUNTU instance, they are:**

1.	First update the **apt** package manager.

        sudo apt update -y

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/Update_apt.png)
 

2.	To install yum and other tools for the creation of a repo, install the **yum-utils** using apt.

        sudo apt install -y yum-utils

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/Install_YUM.png)
 

3.	Test the yum. The result is that it doesn’t have repositories configured, so when you list all the yum repositories it will not be able to find any packages to list as shown below.

        yum search nginx
        
        ```
        
        yum list all
        
        ```

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/Test_YUM.png)
 

4.	Create a test repository as show below as sudo user.

        sudo vi /etc/yum/repos.d/myrepo.repo

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/Create_Repository.png)
 

5.	Provide the repository definition as shown.

        [myrepo]
        name=My extras packages for CentOS 7.4.1708
        baseurl=http://mirror.centos.org/centos/7/os/x86_64/
        enabled=1

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/Repository_Definition.png)
 

6.	Enable the test repository defined using the below command.

        sudo yum-config-manager --enable myrepo

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/Enable_Repository.png)
 

7.	After the enable is successful, test the repository by installing the **nginx** package as shown.

        yum search nginx

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/Install_nginx.png)
 

8.	Now, list all the packages in **yum** repository with the below command.

        yum list all

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/YUM_on_Ubuntu/YUM_on_Ubuntu-PNG/List_YUM_Packages.png)
    
 



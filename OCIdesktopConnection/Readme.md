# Connecting to OCI Instance Desktop from the OCI Cloud Shell

The POC shows how to connect to OCI instance Gnome Desktop using the OCI Cloud Shell and VNC Viewer. 


**Steps to connect OCI Instance Desktop from the OCI Cloud Shell**

**1.**	Create a Virtual Cloud Network in the OCI to create an instance.

   ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/VNCcreation.png)

2.	Create a Network Security Group in VNC to open up the CIDR ports.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/Network_sg.png)
 
3.	The Network Security Groups is created successfully and opened the CIDR ports.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/Network_sgCreate.png)
  
4.	Create the instance by adding the Network Security Group in the VCN.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/CreateInstance.png)
 
5.	Open the Cloud Shell in the OCI console.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/CloudShell.png)
 
6.	SSH to the instance created with the Public IP address and the private key.

        ssh -i <privateKey_FilePath> opc@<PublicIP_Address>

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/SSH.png)
 
7.	Install the GNOME desktop in the VM instance.

        yum groups install "Server with GUI"

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/GNOME_desktop.png)
 
8.	Install the tigervnc-server to allow access to the desktop.

        yum -y install tigervnc_server

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/tigervnc_server.png)
 
9.	Configure the VNC password, when prompted enter password and verify it.

        vncpasswd

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/VNCpassword.png)
 
10.	Enter the following commands to become sudo user and copy the VNC service file to the given path.

        sudo bash

      ```
      cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@\:1.service
      ```

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/VNCserverFile.png)
 
11.	Open the file copied using the vi editor as shown.

        vi /etc/systemd/system/vncserver@\:1.service

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/EditserverFile.png) 

12.	Scroll down to view the <USER> in the file to replace it with opc.
 
        <USER>
 
     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/USERreplace.png)
 
13.	Verify the <USER> is replaced with opc as shown below, save and quit from the file.
 
        opc
 
     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/opcUSER.png)
 
14.	Execute the commands to reload the system daemon and to enable the VNC service as shown below.

        systemctl daemon-reload

      ```
      systemctl enable vncserver@\:1.service
      ```

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/systemctl_enable.png)
 
15.	Execute the commands to start the VNC service and to check the status of the VNC service as shown.

        systemctl start vncserver@\:1.service
        
      ```
      systemctl status vncserver@\:1.service
      ```

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/systemctl_start.png)
 
16.	Open the Firewall in the Instance and connect to the OCI Instance Desktop by Adding the VNC server to the firewall list and verify it by listing.

        firewall-cmd --add-service=vnc-server --permanent

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/firewall.png)
 
17.	On your local machine, start a VNC viewer and establish a VNC connection to the test_instance.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/VNCserver_connect.png)
 
18.	Enter the VNC password that you set earlier in this practice.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/VNCauthentication.png)
 
19.	Click Next to accept the default values as shown.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/Desktop_welcome.png)
 
20.	On successful connection, you will see a Linux Desktop Screen.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OCIdesktopConnection/OCIdesktopPNG/LinuxDesktop.png)
 
 

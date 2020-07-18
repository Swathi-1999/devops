# Connecting to OCI Instance Desktop from the OCI Cloud Shell

The POC shows how to connect to OCI instance Gnome Desktop using the OCI Cloud Shell and VNC Viewer. 

**Steps to connect OCI Instance Desktop from the OCI Cloud Shell **

1.	Create a Virtual Cloud Network in the OCI to create an instance. [VCNcreation]
 

2.	Create a Network Security Group in VNC to open up the CIDR ports. {Network_sg }
 
3.	The Network Security Groups is created successfully and opened the CIDR ports. {Network_sgCreate.png }
  

4.	Create the instance by adding the Network Security Group in the VCN. {CreateInstance.png}
 
5.	Open the Cloud Shell in the OCI console. {CloudShell}
 
6.	SSH to the instance created with the Public IP address and the private key. {SSH}
 
7.	Install the GNOME desktop in the VM instance. {GNOME_desktop}
 
8.	Install the tigervnc-server to allow access to the desktop. {tigervnc_server}
 
9.	Configure the VNC password, when prompted enter password and verify it. {VNCpassword}
 
10.	Enter the following commands to become sudo user and copy the VNC service file to the given path. {VNCserverFile}
 
11.	Open the file copied using the vi editor as shown. {EditserverFile.png}
 

12.	Scroll down to view the <USER> in the file to replace it with opc. {USERreplace}
 
13.	Verify the <USER> is replaced with opc as shown below, save and quit from the file. {opcUSER}
 
14.	Execute the commands to reload the system daemon and to enable the VNC service as shown below. {systemctl_enable}
 
15.	Execute the commands to start the VNC service and to check the status of the VNC service as shown. {systemctl_start.png}
 
16.	Open the Firewall in the Instance and connect to the OCI Instance Desktop by Adding the VNC server to the firewall list and verify it by listing. {firewall}
 
17.	On your local machine, start a VNC viewer and establish a VNC connection to the test_instance. {VNCserver_connect}
 
18.	Enter the VNC password that you set earlier in this practice. {VNCauthentication}
 
19.	Click Next to accept the default values as shown. {Desktop_welcome}
 
20.	On successful connection, you will see a Linux Desktop Screen. {LinuxDesktop}
 


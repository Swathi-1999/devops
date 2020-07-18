# Connecting to OCI Instance Desktop from the OCI Cloud Shell

The POC shows how to connect to OCI instance Gnome Desktop using the OCI Cloud Shell and VNC Viewer. 

**Steps to connect OCI Instance Desktop from the OCI Cloud Shell**

1.	Create a Virtual Cloud Network in the OCI to create an instance. 
 

2.	Create a Network Security Group in VNC to open up the CIDR ports.
 
3.	The Network Security Groups is created successfully and opened the CIDR ports.
  

4.	Create the instance by adding the Network Security Group in the VCN.
 
5.	Open the Cloud Shell in the OCI console.
 
6.	SSH to the instance created with the Public IP address and the private key.
 
7.	Install the GNOME desktop in the VM instance.
 
8.	Install the tigervnc-server to allow access to the desktop.
9.	Open the Firewall in the Instance and connect to the OCI Instance Desktop
 
10.	Configure the VNC password, when prompted enter password and verify it.
 
11.	Enter the following commands to become sudo user and copy the VNC service file to the given path.
 
12.	Open the file copied using the vi editor as shown.
 

13.	Scroll down to view the <USER> in the file to replace it with opc.
 
14.	Verify the <USER> is replaced with opc as shown below, save and quit from the file.
 
15.	Execute the commands to reload the system daemon and to enable the VNC service as shown below.
 
16.	Execute the commands to start the VNC service and to check the status of the VNC service as shown.
 
17.	Add the VNC server to the firewall list and verify it by listing.
 
18.	On your local machine, start a VNC viewer and establish a VNC connection to the test_instance.
 
19.	Enter the VNC password that you set earlier in this practice.
 
20.	Click Next to accept the default values as shown.
 
21.	On successful connection, you will see a Linux Desktop Screen.
 

Twitter:
The POC shows how to connect to OCI instance Gnome Desktop using the OCI Cloud Shell and VNC Viewer. 



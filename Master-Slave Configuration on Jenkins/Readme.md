# Distributed Build Master-Slave Configuration on Jenkins Instance 

To build a master-slave configuration on a Jenkins instance create two AWS EC2 instances as master and agent nodes. Where master node is installed with the Jenkins in it. Further, open up the ports in Jenkins instance to connect to the agent node and master node. Configure the agent node to connect to the master node for communication. On successful connection, build a job on agent node from the master node.

**Steps to Build the Master-Slave Configuration on Jenkins Instance are:**

1.	Create two EC2 instance in AWS console, one for master node and other as agent-node (slave node).
Note: Master node instance is installed with Jenkins.
 
2.	Connect to Jenkins dashboard with the user credentials.
 
3.	Enable the Java Network Launch Protocol (JNLP) port in Jenkins instance.
a.	Navigate to Manage Jenkins and select Configure Global Security under Security as shown below.
 
b.	In Agents section select Random to open the ports for JNLP and click Save.
 

4.	To create an agent node (Slave node) in the Jenkins instance.
a.	Navigate to Manage Jenkins and select Manage Nodes and Clouds under Security Configuration.
 
b.	Select New Node to add a new node to the Jenkins instance. Further, provide the name for the node, select Permanent Agent and click OK.
 
c.	Provide a path in Remote root directory and a label in Labels section.
 
d.	Scroll down to Usage and select Only build jobs with label expressions matching this node, and for Launch method select Launch agent by connecting it to the master as shown below.
 
e.	Scroll down to end of the page and click Save.
 
f.	View the agent node is created with the red cross mark (x), it indicates that the agent node is not connected to the master node yet.
 

5.	Provision the Agent node created in the Jenkins instance.
a.	Click on the new agent node created and to connect to the agent node download the agent.jar file and slave-agent.jnlp file.
 
b.	Transfer the downloaded files to the agent-node instance.
 

6.	Launch agent.jar in the agent-node instance to establish the connection to the master node.
a.	In Jenkins click on the agent node and copy the code to connect as shown below.
 
b.	Open terminal connected to the agent-node and paste the command to execute. On successful execution, the connection will be established by displaying Connected as shown below.
 
 
c.	Open Jenkins dashboard and refresh the agent node page to verify the connection.
 
7.	Create a new job to be executed on the agent node in Jenkins.
a.	In Jenkins Dashboard, navigate to main menu and select New item. Enter the name for the job, select Freestyle project and click OK.
 
b.	Select the check box for Restrict where this project can be run and provide the label for the agent node.
 
c.	In Build section and select Execute shell. Type the echo command as shown below in the command prompt and click Save.
 

d.	On successful Build of the Job in Jenkins view the Console Output.
 
e.	Open new terminal connected to the agent-node instance and navigate to the workspace path to view the Job name in the agent-node instance.
 




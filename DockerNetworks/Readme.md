# Communication Between Docker Containers in Different Networks


This POC, illustrates an example where Containers running in different Docker networks are able to communicate with each other by adding the **Iptables Rules** to DOCKER-USER chain.

**The following are the steps followed in the example:**
 
1.	Create a Docker networks in a Linux Instance.


2.	Create the containers and connect to the Docker network.


3.	Verify the connectivity between the containers by running the command **ping <container_ipaddress>** in the container. The Container will not be able to ping the other container.



4.	Set the IPtables rules to allow the connectivity between containers in different network.

    a)	Run the command ifconfig to get the bridge interface names of the network created.
  
    **Note: Compare the gateway of network created to get the bridge Interface.**
    

    b)	Set the Iptables rules for containers with bridge interface.
    
 
5. Verify the communication between the containers in different network. Now Container will be able to ping the other container.



The

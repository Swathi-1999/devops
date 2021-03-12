# Creating the Network Policy to allow the traffic in GKE #

This POC illustrates how to restrict the traffic to all namespace and a particular namespace where the workloads are deployed.

1.	The following are the steps to create the **Network Policy** to allow the traffic to a namespace:
    
    a.	Create a pod **web server** in default namespace.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/1.jpg)

    b.	Create two namespaces to check the working of Network policy in the Kubernetes Cluster.
    
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/2.jpg)
        
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/3.jpg)

    c.	Apply the label to namespaces created in the previous step.
      
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/4.jpg)

    d.	Create the Network Policy to restrict the traffic to only pods in namespaces that has the label **purpose=production**.
      
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/5.jpg)

    e.	Run the command to create the network policy.
      
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/6.jpg)

    f.	Verify the traffic is blocked to dev namespace.  
      
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/7.jpg)

    g.	Create the pod in **prod** namespace and observe the traffic is not blocked to prod namespace.
       
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/8.jpg)

2.	Following are the steps to create the Network policy to allow traffic to an application from all namespaces.
    
    a.	Create the Network policy to allow the traffic for all namespaces.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/9.jpg)

    b.	Run the command to create the network policy

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/10.jpg)

    c.	Create the namespace in Kubernetes cluster

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/11.jpg)
      
    d.	Verify the traffic allows the pod to deploy in the secondary namespace.
                
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Network%20Policy/12.jpg)




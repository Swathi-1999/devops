# Communicate Between Containers In Same Pod Using A Shared Volume in Kubernetes Cluster

Deploy the pod with two containers in it, where container1 running the **ngnix** application and container2 running **debian**. Both the containers use the Shared Volume in the cluster. On successful deployment of the pod connect to the **nginx** container and fetch the output from the **debian** container in the Kubernetes cluster.

**Steps to Communicate between Containers in same Pod using a Shared Volume are:**

1.	Using Vi Editor create a file as shown below, to create a pod to communicate between containers in the same pod in the Kubernetes cluster.
    
    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/MultiContainer/MultiContainer_PNG/YAML_file.png)
 

2. Copy the below code and paste it in the Vi Editor and save the file.

        apiVersion: v1
        kind: Pod
        metadata:
          name: two-containers
        spec:

          restartPolicy: Never

          volumes:
          - name: shared-data
            emptyDir: {}

          containers:

          - name: nginx-container
            image: nginx
            volumeMounts:
            - name: shared-data
              mountPath: /usr/share/nginx/html

          - name: debian-container
            image: debian
            volumeMounts:
            - name: shared-data
              mountPath: /pod-data
            command: ["/bin/sh"]
            args: ["-c", "echo Hello from the debian container > /pod-data/index.html"]

3. Execute the command shown below to create the Pod in the Kubernetes cluster as shown below with two containers.
   
    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/MultiContainer/MultiContainer_PNG/deployPod.png)
    

4. To list the Pods created in the cluster, run the kubectl get command as shown below.
 
    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/MultiContainer/MultiContainer_PNG/listPods.png)
    

5. Run the below shown command to connect to the **nginx Container** of the Pod running in Kubernetes cluster.
 
    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/MultiContainer/MultiContainer_PNG/connecToContainer.png)
    

6. Run the curl command to fetch the output from the **debian Container** created in the Kubernetes cluster as shown below.

    ![Alt text](https://github.com/Protontech-1803/devops/blob/master/MultiContainer/MultiContainer_PNG/communicateBetweenContainers.png)
    
 



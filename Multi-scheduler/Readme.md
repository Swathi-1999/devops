# Deploying multi-scheduler in Kubernetes cluster and deploy a pod using new scheduler #

This POC illustrates how to deploy a scheduler in the Kubernetes cluster and deploy a pod in the Kubernetes cluster.

**The following are the steps to create the scheduler in the Kubernetes cluster:**

1.	Create a Service Account in kube-system namespace of Kubernetes cluster

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/ServiceAccount.jpg)
      
2.	Create a Cluster Role binding for my-scheduler and bind with system:kube-scheduler cluster role using vi editor

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/ClusterRoleBinding1.jpg)
      
3.	Create a Cluster Role binding for my-scheduler and bind with system:volume-scheduler cluster role

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/ClusterRoleBinding2.jpg)
      
4.	Create a deployment in kube-system namespace using vi editor

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/Deployment.jpg)

5.	The new scheduler is created in the Kubernetes cluster

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/SchedulerList.jpg)

6.	Verify the scheduler my-scheduler pod is created in kube-system namespace

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/SchedulerPod.jpg)

7.	Create the pod in new scheduler
  
    a.	Create a pod yaml file using dry-run command.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/Podfile.jpg)
  
    b.	Edit the pod yaml file using vi editor and provide the name of scheduler to POD.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/Pod.jpg)

8.	Verify the pod is deployed using the new scheduler created in Kubernetes cluster

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Multi-scheduler/Image/List.jpg)

# Enabling Pod Security Policy in Kubeadm Cluster

Kubernetes Pod Security Policies enables to control the security specifications that pods must comply with to run in cluster. In Kubeadm Cluster, the Pod security policy will not be enabled by default. To enable pod security policy (psp) first a psp resource must be created and then enable it by editing kube-apiserver manifest file.
The following steps to enable pod security policy which includes creating resources and restricting the pods.

**1.  Create a privileged-psp.yaml file, which contains policy to allow all pods to run without any restriction.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp1.jpg)

**2.	Create a cluster role to authorize the use of policies.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp2.jpg)

**3.	Create a cluster role binding to grant permission define in role with the policy resource.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp3.jpg)

**4.	Edit the kube-apiserver manifest file /etc/kubernetes/manifests/kube-apiserver.yaml and add PodSecurityPolicy in enable-admission-plugins field. The api-server will be unavailable for some time, while it will restart.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp4.jpg)

**5.	Create a pod with privileged permission and check the status.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp5.jpg)

**6.	Now, create a new restricted policy without privileged permission.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp6.jpg)

**7.	Create cluster role and cluster role binding for the policy.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp7.jpg)

**8.	Delete the privileged policy.** 
##### Note: Privilege permission do not let the restrict policy to apply on kuberntes-admin use.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp8.jpg)

**9.	Run the pod with privileged permission.**
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Kubernetes-Pod-security-policy/psp9.jpg)

**10.	Try to running a simple nginx pod and describe the pod, the container fails.**

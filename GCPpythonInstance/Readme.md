# Create Compute Instance in GCP using Python Client Libraries

The Python client libraries are used to create an instance in the GCP by accessing the Cloud Shell and initialising the gcloud to authorize GCP API calls. Application default credentials are provided in Google API Client Libraries automatically.

**Steps to create compute Instance in GCP using Python Client Libraries, and they are:**

1.	Initially create a project in the GCP to create instance as shown below.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)

2.	Create Bucket in the Storage Browser for the instance to be created in the respective project.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)
 
3.	In the cloud shell execute gcloud init command and Authorize to initialize the cloud shell as shown below.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)
 

4.	In the Cloud Shell create a file startup-script.sh using vi editor as shown below to configure the project settings.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)

     

5.	Create a file create.py using vi editor in the cloud shell to create VM instance as shown below.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)

   
 

6.	Execute the command as shown below to create the compute instance in the GCP by passing the arguments ProjectID and Bucket name.

        python3 create.py <ProjectID> <Bucket_Name>

 
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)

7.	On execution process it displays the project name, instance name, zone and the URL for the compute instance as shown below.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)
 

8.	On successful execution it creates the compute instance in the GCP in a given zone as shown below.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)
 





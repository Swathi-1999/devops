
# Connecting to a PostgreSQL Database using Port Forwarding

Run a PostgreSQL database with persistent storage on OpenShift by accessing the database server in the OpenShift cluster with a command-line shell. Use port forwarding to temporarily expose the database service outside OpenShift to access PostgreSQL database with any database API tool.

**Steps to connect to PostgreSQL Database using Port Forwarding are:**

1.	Create a new project called myproject in the OpenShift cluster using the OpenShift CLI.

          oc new-project myproject

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/myproject.png)
 
2.	Run the below command to create a PostgreSQL database which is used to connect. This will start an instance of a PostgreSQL Database.

          oc new-app postgresql-ephemeral --name database --param DATABASE_SERVICE_NAME=database --param POSTGRESQL_DATABASE=sampledb --param POSTGRESQL_USER=username --param POSTGRESQL_PASSWORD=password

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/createDatabase.png)
 
3.	To List the PostgreSQL database pod created in the OpenShift project, run the below shown command.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/getPods.png)

 
4.	To monitor progress as the database is deployed and made ready, run the below shown command. This will exit when the database is ready to be used.

          oc rollout status dc/database

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/rolloutStatus.png)
 
5.	Run the below shown command to list the details of the pod which is running the database.

          oc get pods --selector name=database

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/databaseRunning.png)
  
6.	Verify the pod running in the Red Hat OpenShift Container Platform console in the project as shown below.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/OpenShiftConsole.png)
 
7.	To get the reference name of the pod, capture the name of the pod in an environment variable by running the command shown below.

          POD=`oc get pods --selector name=database -o custom-columns=NAME:.metadata.name --no-headers`; echo $POD

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/PodName.png)
 
8.	Create an interactive shell within the same container running the database, using the oc rsh command by supplying the name of the pod as shown below.

          oc rsh $POD

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/interactiveShell.png)
 
9.	Verify that the containers running in the database by executing the command shown below.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/containersInDatabase.png)
 
10.	Run the database client for the database provided in the container. For PostgreSQL, use the psql command.

          psql sampledb username

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/psqlDatabase.png)
 
11.	As shown below, create a table in the database and insert a row values to view the table.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/createTable.png)
     
     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/viewTable.png)
 
12.	To exit from the psql and the interactive shell, run the commands shown below.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/exitPSQL.png)
 
13.	Create a connection to the PostgreSQL database, which uses port 5433, and expose it on the local machine where oc is being run as port 15433, as shown below.

        oc port-forward <pod-name> <local-port>:<remote-port>

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/portForwarding.png)

14.	The oc port-forward command is running in the background job. Verify it by running the command as shown below.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/backgroundJobs.png)
 
15.	Run the psql command as shown below from the local machine as the forwarded connection is using port 15433 on the local machine, by explicitly mentioning the port for the database.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/connectDatabaseLocally.png)
 
16.	Kill the running process by executing the command shown below.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/OpenShift_PostgreSQL_Database/OpenShift_PostgreSQL_DatabasePNG/killProcess.png)
 






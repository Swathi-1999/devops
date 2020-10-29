# Trigger Lambda function using AWS MSK
This POC illustrates on how to setup Amazon MSK cluster and configure key elements in the networking configuration. Further, it also explain on how to create a Lambda function that will be invoked by messages in Amazon MSK topics.

Lambda is a consumer application for the Kafka topic. MSK cluster processes records from one or more partitions and sends the payload to the target function. Lambda continues to process batches until there are no more messages in the topic.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/Picture15.png)

## Follow the below steps to Integrate AWS MSK with Lambda function.
#### 1.	To Setup MSK Cluster create a VPC with two private subnet in different availability zones associated with a NAT gateway with access to internet and a public subnet with internet gateway.

a.	Create a VPC using the AWS console.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/1.png)
 
b.	Create another private-subnet-2 within the VPC.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/2.png)
 
c.	Copy the route table (main) ID of private-subnet-1 and Edit the Route table of the private-subnet-2, paste the route table ID in private-subnet-2.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/3.png)
 
d.	Create a NAT gateway and associate it with the Public-subnet.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/4.png)
 
e.	Attach NAT gateway to the private subnet route table.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/5.png)
 
f.	Create a Public subnet within the VPC.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/6.png)
 
g.	Change the Route table of the public-subnet to the route table associated with Internet gateway.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/7.png)
 
**2.	Create an AWS MSK cluster within the newly create VPCs private subnets.**

a.	Create an MSK cluster with custom setting, enter the name and select the MSK default configuration.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/8.png)
 
b.	In Networking select the VPC created in pervious step, select the availability zones and subnets.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/9.png)
 
c.	Select the Broker instance size, Number of brokers per Availability Zone and select storage for per broker as 100GiB.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/10.png)

d.	Select the encryption in transit, leave the other option as default and click to create the MSK cluster

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/11.png)

**3.	Create and setup an EC2 instance kafka-client machine to produce messages into the MSK cluster.**

a.	Create an EC2 instance with Amazon Linux 2 AMI, selecting t2.micro as the instance size, In the Network list select the created VPC, subnet as public-subnet and Auto-assign Public IP list, choose Enable.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/12.png)

b.	Copy the security group ID of the Instance.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/13.png)

c.	Navigate to the MSK cluster and edit the MSK Cluster Security group.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/14.png)

d.	Enter the Instance security group ID as source in inbound rules and open all the traffic for all ports.

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/15.png)

**4.	Install Apache Kafka client libraries and tools on the client machine, and then you create a topic.**

a.	Connect to the EC2 kafka-client instance and run the below command to install java.

    $ sudo yum install java-1.8.0

![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/16.png)

b.	Run the below command to download Apache Kafka.

    $ wget https://archive.apache.org/dist/kafka/2.2.1/kafka_2.12-2.2.1.tgz
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/17.png)
 
c.	Run the following command to Untar the download apache kafka file.

    $tar -xzf kafka_2.12-2.2.1.tgz
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/18.png)
 
d.	Run the below command to configure the credential with the client using the access key and secret access key ID.

    $ aws configure
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/19.png)
 
e.	Run the following command, replacing ClusterArn with the Amazon Resource Name of the MSK cluster to list the details of the Cluster. Copy the Zookeeper connection string for the next command given in output after the MSK cluster will be in active state.
   
    $ aws kafka describe-cluster --region us-east-1 --cluster-arn <ClusterArn>
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/20.png)
 
f.	Change the Directory to the kafka_2.12-2.2.1/bin and run the below command to create a topic. Replace the Zookeeper connection string copied in previous output.
  
    $ ./kafka-topics.sh --create --zookeeper ZookeeperConnectString --replication-factor 2 --partitions 1 --topic MyTopic
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/21.png)
 
**5.	Create and configure the Lambda function within the private subnet of the VPC and setup trigger with the MSK cluster to Invoke Lambda function.**

a.	Create a Lambda function with runtime Node.js 12x.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/22.png)
 
b.	Edit the Lambda execution role and attach the AWSLambdaMSKExecutionRole policy to the lambda function.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/23.png)
 
c.	Edit the VPC setting of the lambda function and select the created VPC and Private subnet.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/24.png)
 
d.	Add and configure MSK trigger to the lambda function. Tigger will takes several minutes for the trigger status to update from Creating to Enabled.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/25.png)
 
e.	Replace the lambda function code with the below code and click to deploy the code.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/26.png)
 
**6.	Invoke the lambda function by message stream by the MSK cluster.**

a.	Run the Following command to use the JVM truststore to talk to the MSK cluster. Replace the JDKfolder JDK folder in the client machine.

    $ cp /usr/lib/jvm/<JDKFolder>/jre/lib/security/cacerts /tmp/kafka.client.truststore.jks
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/27.png)
 
b.	Create a file named client.properties in the bin directory of the Apache kafka and paste the content given below.

    $vi client.properties

    security.protocol=SSL
    ssl.truststore.location=/tmp/kafka.client.truststore.jks
    
![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/28.png)
 
c.	Run the below command to obtain the Bootstrap Broker String Tls. Copy the BootstrapBrokerStringTls from output to use in next command.

    $ aws kafka get-bootstrap-brokers --region us-east-1 --cluster-arn <ClusterArn>
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/29.png)
 
d.	Run the Following command to produce the Message into the MSK cluster. Enter any Message and press Enter for next line

    $ ./kafka-console-producer.sh --broker-list <BootstrapBrokerStringTls> --producer.config client.properties --topic MyTopic
    
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/30.png)
 
e.	Observe the Lambda log event stream.

 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Triggering%20Lambda%20with%20AWS%20MSK/images/31.png)

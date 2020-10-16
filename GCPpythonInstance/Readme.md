# Create Compute Instance in GCP using Python Client Libraries

The Python client libraries are used to create an instance in the GCP by accessing the Cloud Shell and initialising the gcloud to authorize GCP API calls. Application default credentials are provided in Google API Client Libraries automatically.

**Steps to create compute Instance in GCP using Python Client Libraries, and they are:**

1.	Initially create a project in the GCP to create instance as shown below.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateProject.png)

2.	Create Bucket in the Storage Browser for the instance to be created in the respective project.

     ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateBucket.png)
 
3.	In the cloud shell execute gcloud init command and Authorize to initialize the cloud shell as shown below.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/AuthorizeCloudShell.png)
 

4.	In the Cloud Shell create a file startup-script.sh using vi editor as shown below to configure the project settings.

          #!/bin/bash

          # [START startup_script]
          apt-get update
          apt-get -y install imagemagick

          # Use the metadata server to get the configuration specified during
          # instance creation. Read more about metadata here:
          # https://cloud.google.com/compute/docs/metadata#querying
          IMAGE_URL=$(curl http://metadata/computeMetadata/v1/instance/attributes/url -H "Metadata-Flavor: Google")
          TEXT=$(curl http://metadata/computeMetadata/v1/instance/attributes/text -H "Metadata-Flavor: Google")
          CS_BUCKET=$(curl http://metadata/computeMetadata/v1/instance/attributes/bucket -H "Metadata-Flavor: Google")

          mkdir image-output
          cd image-output
          wget $IMAGE_URL
          convert * -pointsize 30 -fill white -stroke black -gravity center -annotate +10+40 "$TEXT" output.png

          # Create a Google Cloud Storage bucket.
          gsutil mb gs://$CS_BUCKET

          # Store the image in the Google Cloud Storage bucket and allow all users
          # to read it.
          gsutil cp -a public-read output.png gs://$CS_BUCKET/output.png

          # [END startup_script]


      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/StartupScript.png)

     

5.	Create a file create.py using vi editor in the cloud shell to create VM instance as shown below.

          import argparse
          import os
          import time

          import googleapiclient.discovery
          from six.moves import input

          # [START list_instances]
          def list_instances(compute, project, zone):
              result = compute.instances().list(project=project, zone=zone).execute()
              return result['items'] if 'items' in result else None
          # [END list_instances]

          # [START create_instance]
          def create_instance(compute, project, zone, name, bucket):
              # Get the latest Debian Jessie image.
              image_response = compute.images().getFromFamily(
                  project='debian-cloud', family='debian-9').execute()
              source_disk_image = image_response['selfLink']

              # Configure the machine
              machine_type = "zones/%s/machineTypes/n1-standard-1" % zone
              startup_script = open(
                  os.path.join(
                      os.path.dirname(__file__), 'startup-script.sh'), 'r').read()
              image_url = "http://storage.googleapis.com/gce-demo-input/photo.jpg"
              image_caption = "Ready for dessert?"

              config = {
                  'name': name,
                  'machineType': machine_type,

                  # Specify the boot disk and the image to use as a source.
                  'disks': [
                      {
                          'boot': True,
                          'autoDelete': True,
                          'initializeParams': {
                              'sourceImage': source_disk_image,
                          }
                      }
                  ],

                  # Specify a network interface with NAT to access the public
                  # internet.
                  'networkInterfaces': [{
                      'network': 'global/networks/default',
                      'accessConfigs': [
                          {'type': 'ONE_TO_ONE_NAT', 'name': 'External NAT'}
                      ]
                  }],

                  # Allow the instance to access cloud storage and logging.
                  'serviceAccounts': [{
                      'email': 'default',
                      'scopes': [
                          'https://www.googleapis.com/auth/devstorage.read_write',
                          'https://www.googleapis.com/auth/logging.write'
                      ]
                  }],

                  # Metadata is readable from the instance and allows you to
                  # pass configuration from deployment scripts to instances.
                  'metadata': {
                      'items': [{
                          # Startup script is automatically executed by the
                          # instance upon startup.
                          'key': 'startup-script',
                          'value': startup_script
                      }, {
                          'key': 'url',
                          'value': image_url
                      }, {
                          'key': 'text',
                          'value': image_caption
                      }, {
                          'key': 'bucket',
                          'value': bucket
                      }]
                  }
              }

              return compute.instances().insert(
                  project=project,
                  zone=zone,
                  body=config).execute()
          # [END create_instance]

          # [START delete_instance]
          def delete_instance(compute, project, zone, name):
              return compute.instances().delete(
                  project=project,
                  zone=zone,
                  instance=name).execute()
          # [END delete_instance]

          # [START wait_for_operation]
          def wait_for_operation(compute, project, zone, operation):
              print('Waiting for operation to finish...')
              while True:
                  result = compute.zoneOperations().get(
                      project=project,
                      zone=zone,
                      operation=operation).execute()

                  if result['status'] == 'DONE':
                      print("done.")
                      if 'error' in result:
                          raise Exception(result['error'])
                      return result

                  time.sleep(1)
          # [END wait_for_operation]

          # [START run]
          def main(project, bucket, zone, instance_name, wait=True):
              compute = googleapiclient.discovery.build('compute', 'v1')

              print('Creating instance.')

              operation = create_instance(compute, project, zone, instance_name, bucket)
              wait_for_operation(compute, project, zone, operation['name'])

              instances = list_instances(compute, project, zone)

              print('Instances in project %s and zone %s:' % (project, zone))
              for instance in instances:
                  print(' - ' + instance['name'])

              print("""
          Instance created.
          It will take a minute or two for the instance to complete work.
          Check this URL: http://storage.googleapis.com/{}/output.png
          Once the image is uploaded press enter to delete the instance.
          """.format(bucket))

              if wait:
                  input()

              print('Deleting instance.')

              operation = delete_instance(compute, project, zone, instance_name)
              wait_for_operation(compute, project, zone, operation['name'])


          if __name__ == '__main__':
              parser = argparse.ArgumentParser(
                  description=__doc__,
                  formatter_class=argparse.RawDescriptionHelpFormatter)
              parser.add_argument('project_id', help='Your Google Cloud project ID.')
              parser.add_argument(
                  'bucket_name', help='Your Google Cloud Storage bucket name.')
              parser.add_argument(
                  '--zone',
                  default='us-central1-f',
                  help='Compute Engine zone to deploy to.')
              parser.add_argument(
                  '--name', default='demo-instance', help='New instance name.')

              args = parser.parse_args()

              main(args.project_id, args.bucket_name, args.zone, args.name)
          # [END run]


      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/CreateInstanceCodeSnippet.png)

   
 

6.	Execute the command as shown below to create the compute instance in the GCP by passing the arguments ProjectID and Bucket name.

        python3 create.py <ProjectID> <Bucket_Name>

 
      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/ExecuteCreateInstanceCode.png)
      

7.	On execution process it displays the project name, instance name, zone and the URL for the compute instance as shown below.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/ExecutionMessage.png)
 

8.	On successful execution it creates the compute instance in the GCP in a given zone as shown below.

      ![Alt text](https://github.com/Protontech-1803/devops/blob/master/GCPpythonInstance/GCPpythonInstancePNG/InstanceCreated.png)
 





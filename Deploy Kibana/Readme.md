# Deploy Kibana in AWS EKS
This POC illustrates how to deploy Kibana in AWS Elastic Kubernetes service. Kibana is a data visualization dashboard for Elasticsearch. It provides visualization capabilities on top of the content indexed on an Elasticsearch cluster.

** The following steps to deploy Kibana in AWS EKS and assume you already have a cluster.**


** 1.	Run the following command to list the worker nodes **

    $ kubectl get nodes
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/1.png)
 
** 2.	Download and Install Helm package manager using the below command.**

    $ wget https://get.helm.sh/helm-v3.4.1-linux-amd64.tar.gz 
    $ tar -zxvf helm-v3.4.1-linux-amd64.tar.gz
    $ sudo mv linux-amd64/helm /usr/local/bin/helm
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/2.png)

** 3.	Add Elasticsearch repo to the helm **

    $ helm repo add elastic https://helm.elastic.co
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/3.png)
** 4.	Install Elasticsearch using the helm chart **

    $ helm install elasticsearch elastic/elasticsearch
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/4.png)

** 5.	Create a file kibana.yaml and paste the below values to the file.**

    cat >kibana.yaml 
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      labels:
        app: kibana
        release: kibana
      name: kibana-kibana
      namespace: default
    spec:
      progressDeadlineSeconds: 600
      replicas: 1
      revisionHistoryLimit: 10
      selector:
        matchLabels:
          app: kibana
          release: kibana
      strategy:
        type: Recreate
      template:
        metadata:
          creationTimestamp: null
          labels:
            app: kibana
            release: kibana
        spec:
          containers:
          - env:
            - name: ELASTICSEARCH_HOSTS
              value: http://elasticsearch-master:9200
            - name: SERVER_HOST
              value: 0.0.0.0
            - name: NODE_OPTIONS
              value: --max-old-space-size=1800
            image: docker.elastic.co/kibana/kibana:7.10.0
            imagePullPolicy: IfNotPresent
            name: kibana
            ports:
            - containerPort: 5601
              protocol: TCP
            readinessProbe:
              exec:
                command:
                - sh
                - -c
                - |
                  #!/usr/bin/env bash -e

                  # Disable nss cache to avoid filling dentry cache when calling curl
                  # This is required with Kibana Docker using nss < 3.52
                  export NSS_SDB_USE_CACHE=no

                  http () {
                      local path="${1}"
                      set -- -XGET -s --fail -L
                      if [ -n "${ELASTICSEARCH_USERNAME}" ] && [ -n "${ELASTICSEARCH_PASSWORD}" ]; then
                        set -- "$@" -u "${ELASTICSEARCH_USERNAME}:${ELASTICSEARCH_PASSWORD}"
                      fi
                      STATUS=$(curl --output /dev/null --write-out "%{http_code}" -k "$@" "http://localhost:5601${path}")
                      if [[ "${STATUS}" -eq 200 ]]; then
                        exit 0
                      fi

                      echo "Error: Got HTTP code ${STATUS} but expected a 200"
                      exit 1              }

                  http "/app/kibana"
              failureThreshold: 3
              initialDelaySeconds: 10
              periodSeconds: 10
              successThreshold: 3
              timeoutSeconds: 5
            resources:
              limits:
                cpu: "0.2"
                memory: 1Gi
              requests:
                cpu: "0.2"
                memory: 1Gi
            securityContext:
              capabilities:
                drop:
                - ALL
              runAsNonRoot: true
              runAsUser: 1000
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
          dnsPolicy: ClusterFirst
          restartPolicy: Always
        
** 6.	Deploy kibana in EKS cluster using below command.**

      $ kubectl create –f kibana.yaml
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/5.png)
 
** 7.	Create an external service for Kibana using below command **

    $ kubectl expose deploy kibana-kibana –type=LoadBalancer –target-port=5601 –port=5601
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/6.png)
 
** 8.	Run the following command to list services and Copy the external DNS name **

    $ kubectl get svc
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/7.png)
 
** 9.	paste the DNS name in the  browser with Port to view the Kibana Dashboard **
 ![Alt text](https://github.com/Protontech-1803/devops/blob/master/Deploy%20Kibana/img/8.png)


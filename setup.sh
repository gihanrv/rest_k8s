#!/bin/bash
#check kind is alreday installed
kind --version

if [ $? -ne 0 ] ; then
# install kind if not present
   curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64 && chmod +x ./kind && sudo mv ./kind /usr/local/bin/kind

fi    

# create a kind cluster with 2 worker nodes 
cluster_validate=$(kubectl cluster-info --context kind-kind-multi-node)

if [ $? -ne 0 ] ; then
    kind create cluster --config kind-cluster.yml --name kind-multi-node && sleep 20 && kubectl get nodes
    cluster="created"
fi
#Build Application
image_validate=$(docker images |grep rest_k8s)

if [ $? -ne 0 ] ; then
   echo -e "Building Docker Image \n\tImage Name: rest_k8s \n\tTag: 0.1"
   docker build -t rest_k8s:0.1 .
   docker images rest_k8s:0.1

fi

#add local image into kind cluster
if [ "$cluster" == "created" ]; then
   echo -e "\nAdding Application Docker Image Into Kind Cluster\n"
   kind --name kind-multi-node load docker-image rest_k8s:0.1 && sleep 2
fi

echo -e "\nApplication Docker Image \n"
docker images rest_k8s:0.1


## Deploy Application on K8s
echo -e "\nDeploying REST Application . . . . .\n" 
cd manifest && kubectl apply -f app/namespace.yaml -f app/deployment.yaml -f app/service.yaml && sleep 20 && echo -e "\t\t\t(DONE)\n"

## Deploy Nginx Ingress on K8s

echo -e "\nDeploying Nginx Ingress . . . . .\n"
kubectl apply -f ingress/namespace.yaml -f ingress/service-account.yaml -f ingress/cluster-role.yaml -f ingress/cluster-role-binding.yaml -f ingress/configmap.yaml -f ingress/custom-conf-configmap.yaml -f ingress/deployment.yaml -f ingress/service.yaml && sleep 20 && echo -e "\t\t\t(DONE)\n"

echo -e "\nDeploying Nginx Ingress Rules . . . . .\n"
kubectl apply -f ingress-rule/ingress-rule.yaml -f ingress-rule/tls-secret.yaml && sleep 10 && echo -e "\t\t\t(DONE)\n"

## Deploy Monitoring tool on K8s
echo -e "\nDeploying Monitoring and Metrices . . . . .\n"
kubectl apply -f monitoring/namespace.yaml -f monitoring/agent-configmap.yaml -f monitoring/grfana-agent.yaml && sleep 20 && echo -e "\t\t\t(DONE)\n"

echo "###############################################"
echo -e "\n      ---Deployment Completed---- \n\n"
echo "###############################################"

echo -e "
  -> Access Web Application

    1. Add this '127.0.0.1   platformeng.com' into your hosts file
    
    2. Port forward Nginx Ingress Load Balancer
        i.  kubectl port-forward service/ingress-nginx -n ingress-nginx 8081:80  And use http://platformeng.com:8081/
       ii. kubectl port-forward service/ingress-nginx -n ingress-nginx 8082:443 And use https://platformeng.com:8080/ 

    3. View k8s cluster metrics
       i.  kubectl port-forward service/grafana-agent -n monitoring 8082:80 
        **** Grafana agent should be configured with cortex remote_write endpoint.
"

# REST API On Kind Kubernetes Cluster

## Description
**Build a service that responds to an HTTP GET request and returns Timestamp & hostname**
- The Python Flask application "app.py" will return the date, time, timestamp, and hostname.
- The Docker file installs application dependencies based on requirements.txt files on top of the Python Alpine base image.
- The Docker images have the tag "rest k8s:O.1" and expose the application on TCP 4000; they are 72.6 MB in size.
- Manifest files are used to deploy the app as a Deployment with two replica sets and to expose the server as CLUSTER-IP.
- There are manifest files for deploying nginx's ingress controller, ingress rules, and the Grafan agent as a solution for metrics and monitoring (the Grafana agent's deployment needs to be improved further). 

#### Tech Stack
* Kind K8s cluster
* Docker
* python Flask
* Shell script
* Grafana Agent

####  Read More
   * **Kind** : kind is a tool for running local Kubernetes clusters using Docker container “nodes”. kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI. https://kind.sigs.k8s.io/.
   * **Python Flask** : Flask is a web framework, it’s a Python module that lets you develop web applications easily. https://pythonbasics.org/what-is-flask-python/
   *  **Grafana agent**: Grafana Agent focuses metrics support around Prometheus’ remote_write protocol, so some Prometheus features, such as querying, local storage, recording rules, and alerts are not present https://grafana.com/docs/agent/latest/.


## Getting Started

### Dependencies
**!!** Docker must be installed on the host that your wish to run kind k8s cluster.
You can use install_docker.sh script to install docker on your host machine.
```
chmod +x install_docker.sh && ./install_docker.sh
```
### How to build and deploy application

**Use setup.sh shell script to create environment and deploy application on kind cluster**
```
 chmod +x setup.sh && ./setup.sh
```
The ingress is using  "platformeng.com" as the host so you need to add a entry "127.0.0.1 platformeng.com" in your hosts file
- Linux: /etc/hosts
- Windows: C:\Windows\System32\drivers\etc\hosts

**Access the web application**
```
kubectl port-forward service/ingress-nginx -n ingress-nginx 8081:80  And use http://platformeng.com:8081/
kubectl port-forward service/ingress-nginx -n ingress-nginx 8082:443 And use https://platformeng.com:8082/ 
```

<img width="407" alt="https_default" src="https://user-images.githubusercontent.com/29304495/199858686-4d52804f-f488-4dc4-9f25-0fbba3dbd408.png">

<img width="398" alt="https_with_tls_selfsign" src="https://user-images.githubusercontent.com/29304495/199858719-9962da0a-9c2f-450b-a667-46f140701602.png">

**setup.sh script will**
1. Install kind if it does not already exist on the host.
2. Create a Docker image with **rest k8s:0.1**.
3. Insert the **rest k8s:0.1** image into the kind cluster.
4. Deploy the web application, Nginx ingress controller, Ingress rules, and Grafana agent for metrics/monitoring using the Kubernetes manifest files. 

#### Tree View
```
├── Dockerfile
├── README.md
├── app.py
├── index.php
├── kind-cluster.yml
├── manifest
│   ├── app
│   │   ├── deployment.yaml
│   │   ├── namespace.yaml
│   │   └── service.yaml
│   ├── ingress
│   │   ├── cluster-role-binding.yaml
│   │   ├── cluster-role.yaml
│   │   ├── configmap.yaml
│   │   ├── custom-conf-configmap.yaml
│   │   ├── deployment.yaml
│   │   ├── namespace.yaml
│   │   ├── service-account.yaml
│   │   └── service.yaml
│   ├── ingress-rule
│   │   ├── ingress-rule.yaml
│   │   └── tls-secret.yaml
│   └── monitoring
│       ├── agent-configmap.yaml
│       ├── grfana-agent.yaml
│       └── namespace.yaml
├── requirements.txt
└── setup.sh
```




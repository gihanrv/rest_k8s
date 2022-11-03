# REST API On Kind Kubernetes Cluster

## Description
Build a service that responds to an HTTP GET request and returns Timestamp & hostname

#### Tech Stack
* Kind K8s cluster
* Docker
* python Flask
* Shell script
* Grafana Agent

####  Read More
   * **KIND** : kind is a tool for running local Kubernetes clusters using Docker container “nodes”. kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI. https://kind.sigs.k8s.io/
   * **Python Flask** : Flask is a web framework, it’s a Python module that lets you develop web applications easily. https://pythonbasics.org/what-is-flask-python/
   *  **Grafna agent**: Grafana Agent focuses metrics support around Prometheus’ remote_write protocol, so some Prometheus features, such as querying, local storage, recording rules, and alerts are not present https://grafana.com/docs/agent/latest/


## Getting Started

### Dependencies
**!!** Docker must be installed on the host that your wish to run kind k8s cluster
You can use install_docker.sh script to install docker on your host mechine
```
chmod +x install_docker.sh && ./install_docker.sh
```
### How to build and deploy application.

**Use setup.sh shell script to create environment and deploy application on kind cluster**
```
 chmod +x setup.sh && ./setup.sh
```

setup.sh script 
1. Install kind if not exist in the host
2. Build the docker image with **rest_k8s:0.1**
3. Load **rest_k8s:0.1** image into kind cluster
4. Run kubernets manifest files to deploy webapplication , Nginx ingress controller , Ingress rules and Grafana agent for metrics/monitoring

#### Tree View
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





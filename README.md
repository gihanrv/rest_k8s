# REST API On Kind Kubernetes Cluster

## Description
Build a service that responds to an HTTP GET request and returns Timestamp & hostname

#### Tech Stack
* Kind K8s cluster
* Docker
* python Flask
* Shellscript
* Grafana Agent

####  Read More
   * KIND : kind is a tool for running local Kubernetes clusters using Docker container “nodes”. kind was primarily designed for testing Kubernetes itself, but may be used for local development or CI. https://kind.sigs.k8s.io/
   * Python Flask : Flask is a web framework, it’s a Python module that lets you develop web applications easily. https://pythonbasics.org/what-is-flask-python/
   *  Grafna agent: Grafana Agent focuses metrics support around Prometheus’ remote_write protocol, so some Prometheus features, such as querying, local storage, recording rules, and alerts are not present https://grafana.com/docs/agent/latest/


## Getting Started


### Dependencies
!! Docker must be installed on the host that your wish to run kind k8s cluster

### Executing program


```
```

```
* change you directory to : cd IAC/terragrunt/operation-task-use1/
* Check the plan          : terragrunt run-all plan
* Apply changes           : terragrunt run-all apply
* Push image to ECR       : ./ducker_push.sh

```


## Data ingestion pipeline

### How would you design the high available system ?

```
### How would you set up monitoring to identify bottlenecks as the load grows?



### How can those bottlenecks be addressed in the future?

```
-   Idle connections in the database might consume compute resources, such as memory and CPU, Enhance monitorig to identify the the Idle connections in the database
    and kill the queris if exist
    Integrate Amazon ElastiCach (redis) solution for repeated long queries.
   
-  Increase the number of connectors to reduce the consumer lag.
   
```

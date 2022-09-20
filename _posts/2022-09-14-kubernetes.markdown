---
layout: single
#classes: wide
title:  "Kubernetes"
date:   2022-09-14 15:31:50 +0800
categories: kubernetes,k8s,container,orchestration
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## summary

* provide orchestration for containers (scaling, ha, load balancing, bring up a dead container)
* only knows how to pull from registry
  * no composing capability
* components
  * high level architecture
    * cluster > node > pod > containers

| component     | sub-component           | explaination                                                          |
| :------------ | :---------------------- | :-------------------------------------------------------------------- |
| container     |                         |                                                                       |
| pod           |                         | where containers run; runs on node                                    |
| (worker)node  |                         | can be a vm or physical machine                                       |
| (worker)node  | kublet                  | make sure `container` run in a `pod`                                  |
| (worker)node  | kube-proxy              | controls network in/out of cluster                                    |
| (worker)node  | container runtime       | software that runs `container`                                        |
| control plane |                         | the `brain` of k8s                                                    |
| control plane | kube-apiserver          | api to control the `plane` - via `kubectl`(CLI) or `Dashboard`(addon) |
| control plane | etcd                    | kvp data used by `plane`                                              |
| control plane | kube-scheduler          | `brain` that assigned `pod` to `node` to run on                       |
| control plane | kube-controller-manager | runs `controller` process                                             |
| control plane | node controller         | make sure node is deleted after it stop responding                    |
| control plane | route controller        | coutrol route in cloud                                                |
| control plane | service controller      | control load balancer                                                 |
| cluster       |                         | group of node(vm/pc) working as a unit                                |

## Minikube

### summary

<https://minikube.sigs.k8s.io/docs/start/>

* not for production used
* only 1 node will be created in the cluster

### installation

```sh
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo usermod -aG docker $USER && newgrp docker
sudo sysctl fs.protected_regular=0
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker ${USER}
// minikube stop
minikube start // start `minikube` as docker container. do not `sudo`
minikube version
minikube kubectl -- get pods -A // install kubectl
alias kubectl="minikube kubectl --" // create convenient alias
```

### dashboard

#### visit remotely

* start proxy

```sh
// killall kubectl // same as kill -15 <pid>
kubectl proxy --address='0.0.0.0' --disable-filter=true &
```

* visit <http://192.168.1.110:8001/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/workloads?namespace=default>

#### visit locally(from host)

* launch dashboard locally in host machine

```sh
minikube dashboard
```

### create sample app

```sh
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4 // create deployment from image
kubectl expose deployment hello-minikube --type=NodePort --port=8080 // expose app to port 8080
minikube service hello-minikube // launch in browser
kubectl port-forward service/hello-minikube 7080:8080 // forward to localhost:7080. closing terminal will cancel the port forwarding
```

* you can access deployment @ <http://localhost:7080>
* you can't access deployment remotely. you need to reverse proxy from nginx

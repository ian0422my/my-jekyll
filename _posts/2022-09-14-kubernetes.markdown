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

## Cheatsheet

* provide orchestration for containers (scaling, ha, load balancing, bring up a dead container)
* master and worker nodes concept
* yaml
  * meta, specs, status(create by k8s)
  * deployment and service normally is put together(demarcated by `---`)
* pod is smallest controllable unit
* self healing
  * changes will be auto provisioned based on deployment config
    * e.g. if you delete a pod for a deployment, k8s will auto create the pod again!!!
* changes(increase # of replicas) to deployment and below will be automatically reflected when user edit deployment(e.g. `kubectl edit deployment nginx-deployment`)
* basic command

```sh
kubectl create deployment nginx-depl --image=nginx
kubectl [get/delete] deployments/replicasets/pods
kubectl edit deployment nginx-deployment
kubectl apply -f nginx-deployment.yaml
kubectl exec -it <pod> sh
kubectl logs -f --tail 100 <pod>
kubectl get <pods/services/deployments> [-o wide/yaml]
```

* spec.service.type
  * default is `ClusterIP` (internal ip with load balancing capability)
  * `LoadBalancer` (extenal ip with load balancing capability)
* spec.service.port
  * `LoadBalancer` will have 3 ports because external ip will get a port too
    * external:nodeport -> service:port
    * service:port -> service:targetport (where targetport refers to containers port)

## architecture

<img src="../assets/images/summary-architecture.drawio.png" alt="drawing" width="450"/>

* basic(illustration)
  * cluster(group of pc) > node(pc) > pod(application)
* advanced
  * cluster
    * storage
    * master node
      * control plane
        * api server(gateway)
        * controller manager(state detection)
        * scheduler(resource allocation)
        * etcd(state)
    * worker node
      * kublet(manager)
      * kubeproxy(network manager)
      * container runtime(e.g. docker)
      * ingress(network)
      * volume(storage)
      * deployment or statefulset
        * replicateset
          * pod(abstraction of container)
            * service(network)
            * configmap(kvp)
            * secret(kvp)
            * container

| node   | sub-component      | explaination                                                                          |
| :----- | :----------------- | :------------------------------------------------------------------------------------ |
| node   |                    | can be vm or pc                                                                       |
| worker | cluster            | group of node(vm/pc) working as a unit                                                |
| worker | deployment         | blueprint for pod                                                                     |
| worker | pod                | abstraction of containers so that container technology can be change                  |
| worker | kublet             | agent; make sure `container` run in a `pod`; middleman between `node` and `container` |
| worker | kube-proxy         | controls network in/out of cluster; smart forwarding with performant                  |
| worker | container runtime  | engine that runs container(e.g. docker); managed by `kublet`                          |
| master | control plane      | place where the orchestration works                                                   |
| master | kube-apiserver     | api to control the `plane` - via `kubectl`(CLI) or `Dashboard`(addon); 6443           |
| master | etcd               | kvp data used by `plane`; `brain`                                                     |
| master | kube-scheduler     | `brain` that assigned `pod` to `node` to run on(based on idlity)                      |
| master | node controller    | make sure node is deleted after it stop responding                                    |
| master | route controller   | coutrol route in cloud                                                                |
| master | service controller | control load balancer                                                                 |

## components

<https://www.youtube.com/watch?v=X48VuDVv0do>

* `cluster`
  * group of `node`
* `master node`
  * manage k8s via
    * `dashboard`
    * `api server`(with login)
    * `kubectl`(CLI tools; most powerful)
  * manage orchestration
    * E.g. when `pod` dies in a `node`
      * `kublet` update state in `etcd`???
      * `controller manager` detect changes in `etcd` and inform `scheduler` to create new `pod`
      * `scheduler` ***calculate*** which `node` to create new `pod`(based on the most resource - cpu, ram, or most idle) and inform `kublet` to create new `pod`
      * `kublet` in the `node` will then bring up a new `pod`
* `worker node`
  * aka `node`
  * has own ip (ephemeral)
    * solve using `service`
  * pod/node is managed by `kubelet`
  * network is managed by `kube proxy`
* `kubelet`
  * ***brain*** in a `node`
  * runs `container` using `container runtime`(e.g. docker)
  * runs `container` in `pod`
  * runs `pod` in `node`
* `kube proxy`
  * intelligently managed the network within `cluster`(e.g. app1 in node1 talks to db1 in node1, not db2 in node2 -> reduce network latency)
* `deployment`
  * blueprint of `pod` setup
  * manage `docker` image
  * manage `replicateset`
* `replicateset`
  * manage `pod` replication for HA purpose. also can use to scale up/down
  * a web `pod` in `node`1 can see app `pod` in `node`2 (because `service` in app `pod` act as load balancer)
  * stateless
  * not for application such as database
* `statefulset`
  * like `deployment` but stateful
  * can use to scale up/down
  * deployment of `statefulset` is very complicated
    * try to create this app(e.g. db) outside of k8s
* `pod`
  * ***abstraction*** of containers(so that container technology can be change)
    * hence, pod(app) will communicate to another(pod) despite different container technology
  * normally 1 pod only runs 1 container(can run multiple containers in 1 pod -> but not a good practice)
  * each pod has its own ip(can be see within app)
  * ***ephemeral***
    * die easily; when die, ip change. Hence, `service` is needed
* `service`
  * static ip
  * attached to each pod
  * managed by `kube proxy`
  * `service` can see other `service` within the same `node`
  * also served as ***load balancer*** for the same `pod` on other `deployment`
  * when `pod` dies, `service` will remain
  * types
    * external
      * accessible via host
      * url is http://<node ip>:port
        * not friendly. Hence, `ingress` is needed
    * internal
      * accessible by `pod` of the same `node`
* `ingress`
  * port forward from internet to `service`(external)
* `configmap`
  * store external pod info, properties, environment variables (e.g. database connection string)
  * can be used by `pod` (e.g. when db connection string changes, no need to rebuild app container. Just change `configmap` and app container will automatically see the changes)
* `secret`
  * works exactly like `configmap` but stores confidential data in base64
* `volume`
  * external harddisk (to prevent pod shutdown and losing the data)
  * can reside in host(`storage`)
* `storage`
  * external harddisk plugged into host
  * not part of k8s
* `kubeadm`
  * use to bootstrap cluster

## yaml

* meta
* spec(pod - meta,spec,status)
* status
  * auto gen by k8s
* all resources can have label(s)
* selectors
  * use to select ***other resource by label***
  * 2 types of selectors
    * equality (e.g. `environment=production,tier!=frontend`)
      * supported by service
    * set (e.g. `{key: environment, operator: NotIn, values: [dev]}`)
      * supported by deployment, replicaset, job, daemonset

### Deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-depl
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```

* json equivalent

```json
{
  "apiVersion": "apps/v1",
  "kind": "Deployment",
  "metadata": {
    "name": "nginx-depl",
    "labels": {
      "app": "nginx"
    }
  },
  "spec": {
    "replicas": 1,
    "selector": {
      "matchLabels": {
        "app": "nginx"
      }
    },
    "template": {
      "metadata": {
        "labels": {
          "app": "nginx"
        }
      },
      "spec": {
        "containers": [
          {
            "name": "nginx",
            "image": "nginx",
            "ports": [
              {
                "containerPort": 80
              }
            ]
          }
        ]
      }
    }
  }
}
```

### service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: svc
spec:
  ports:
  - name: tcp
    protocol: TCP
    port: 443
    targetPort: 
  - name: tcp
    protocol: TCP
    port: 80
    targetPort: 80
  selector:
    app: nginx
```

* json equivalent

```json
{
  "apiVersion": "v1",
  "kind": "Service",
  "metadata": {
    "name": "svc"
  },
  "spec": {
    "ports": [
      {
        "name": "tcp",
        "protocol": "TCP",
        "port": 443,
        "targetPort": 443
      }
    ],
    "selector": {
      "app": "nginx"
    }
  }
}
```

## Minikube

### <https://www.youtube.com/watch?v=X48VuDVv0do> (34:47)

* open source
* need docker
  * `minikube start` will install `docker` autoamatically or use the existing one if have
* there's only 1 node(where master and worker runs in the same node)
  * meant for local testing
* use `kubectl` to talk to `api server`(master node)
* need to run on virtualization (e.g. virtualbox, hyper-v)

#### architecture

* host
  * hypervisor(e.g. virtalbox)
    * vm
      * docker
      * k8s
        * cluster
          * master
          * worker

#### uninstall

<https://stackoverflow.com/questions/44698283/how-to-completely-uninstall-kubernetes>

```sh
kubeadm reset
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*   
sudo apt-get autoremove
sudo rm -rf ~/.kube
sudo kubeadm reset -force
```

* reboot

#### installation

```sh
//sudo ufw allow 10248
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
//sudo systemctl enable kubeleet.service
swapoff -a
//minikube delete
minikube delete --all --purge
docker rmi gcr.io/k8s-minikube/kicbase:v0.0.34 gcr.io/k8s-minikube/kicbase:v0.0.33
minikube start
//minikube start --extra-config=kubelet.cgroup-driver=systemd
//minikube start --driver=docker --extra-config=kubelet.cgroup-driver=systemd --v=5 --alsologtostderr
```

## Kubectl

### basic

```sh
kubectl get nodes
minikube status
kubectl version
kubectl create deployment nginx-depl --image=nginx
kubectl get deployment
kubectl get pod
kubectl get replicaset
kubectl describe pod <pod/service name>
```

* self healing
  * able to detect changes in configuration file/state and recover to original state
    * E.g.
      * find image nginx version and add ":1.16". save the changes. old `pod`/`replicateset` will be removed. new one will be created based on the latest `deployment`

```sh
kubectl edit deployment nginx-depl
```

* changes `replica` from 1 to 2. Once changes is saved, 2 components will be created

### debugging pods

```sh
kubectl create deployment mongo-depl --image=mongo
kubectl get pod|grep mongo
kubectl logs -f --tail=100 <the mongo-depl pod id> // tail
kubectl exec -it <the mongo-depl pod id> sh
```

### delete pods/deployment

```sh
kubectl delete deployment mongo-depl
kubectl delete pod <the mongo-depl pod id>
```

### configuration file(yaml)

* yaml
* 3 parts structure
  * `metadata`
    * `deployment` or `service`
  * `spec`
    * value depending on `type`
  * `status`
    * auto updated by k8s continuously; pull from `etcd`
* `pod` configuration resides within `deployment` configuration
  * i.e.
    * `metadata`+`spec`+`status` (`deployment`)
      * `metadata`+`spec`+`status` (`pod`)
  
#### connecting components

##### labels and selectors

* label
  * name sticked to a resource/component

```yaml
labels:
  app: nginx
```

* selectors
  * use to refer to the label(s) of a component

```yaml
selector:
  app: nginx
```

##### port and targetPort

* deployment

```yaml
        ports:
        - containerPort: 8080
```

* service

```yaml
      port: 80
      targetPort: 8080 // refers to `containerPort` in `deployment`
```

#### example

##### nginx-service.yaml

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

##### nginx-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.16
        ports:
        - containerPort: 8080
```

#### apply configuration file

* ***changes save on the yaml can be used for CRUD***

```sh
kubectl apply -f nginx-deployment.yaml
kubectl apply -f nginx-service.yaml
```

#### verify pod's container ip (172.17.0.0/16)

```sh
kubectl get pods
kubectl get pods nginx-deployment-78cc6468fb-48zd6 -o wide // e.g. ip=172.17.0.4
```

#### verify servcice targetPort is pointing towards pod's internal ip and port (i.e. 172.17.0.2:8080)

```shp
kubectl get service
kubectl describe service nginx-service // i.e. Endpoints: 172.17.0.2:8080,172.17.0.4:8080
```

### complete project

* 1:16:19
* mongoexpress, mongodb
* flow

```txt
browser -> external service -> mongo express + secret(userid, password) -> internal service -> mongodb
30000 -> 8081 
```

* snippet

#### snippet

<img src="../resources/kubernetes/mongoexpress.png" alt="drawing" width="600"/>

| metadata.name           | kind              | snippet                                                                                                                                                                                                                                                      |
| :---------------------- | :---------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| mongo-secret            | secret            | ...<br>mongo-root-username: dXNlcm5hbWU=<br>...                                                                                                                                                                                                              |
| mongo-deployment        | deployment        | ...<br>containerPort: 27017<br>...<br>name: MONGO_INITDB_ROOT_USERNAME<br>valueFrom:<br>secretKeyRef:<br>name: mongodb-secret<br>key: mongo-root-username                                                                                                    |
| mongo-service           | service(internal) | ...<br>protocol: TCP<br>...<br>port: 37017<br>targetPort: 27017<br>...                                                                                                                                                                                       |
| mongodb-configmap       | configmap         | ...<br>database_url: mongodb-service<br>database_port: 37017<br>...                                                                                                                                                                                          |
| mongoexpress-deployment | deployment        | ...<br>name: ME_CONFIG_MONGODB_ADMINUSERNAME<br>valueFrom:<br>secretKeyRef:<br>name: mongodb-secret<br>key: mongo-root-username<br>...<br>name: ME_CONFIG_MONGODB_PORT<br>valueFrom:<br>configMapKeyRef:<br>name: mogodb-configmap<br>key: database_port<br> |
| mongoexpress-service    | service(external) | ...<br>type: LoadBalancer<br>...<br>protocol: TCP<br>port: 8081<br>targetPort: 8081<br>nodePort: 30000                                                                                                                                                       |

#### mongodb-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongodb-deployment
  labels:
    app: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongodb
        image: mongo
        ports:
        - containerPort: 27017
        env:
        - name: MONGO_INITDB_ROOT_USERNAME
          value: 
        - name: MONGO_INITDB_ROOT_PASSWORD
          value: 
```

#### mongo-secret.yaml

* data must be base64 encoceed

```sh
echo -n 'username'|base64
echo -n 'password'|base64
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: mongodb-secret
type: Opaque
data:
  mongo-root-username: dXNlcm5hbWU=
  mongo-root-password: cGFzc3dvcmQ=
```

* create `secret`

```sh
kubectl apply -f mongo-secret.yaml
kubectl get secret
```

#### apply the secrets into mongo-deployment.yaml

* edit `mongo-deployment.yaml` and replace line below accordingly

```yaml
...
        env:
        - name: MONGO_INITDB_ROOT_USERNAME
          valueFrom: 
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-username
        - name: MONGO_INITDB_ROOT_PASSWORD
          valueFrom: 
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-password
...
```

* apply and run

```sh
kubectl apply -f mongo-deployment.yaml
kubectl get pods
kubectl logs -f --tail 100 mongodb-deployment-844789cd64-n8dhf
```

#### mongodb-service (internal)

* add content below into the bottom of `mongo-deployment.yaml`
  * `---` is document separation in yaml

```yaml
...
---
apiVersion: v1
kind: Service
metadata:
  name: mongodb-service
spec:
  selector:
    app: mongodb
  ports:
    - protocol: TCP
      port: 27017
      targetPort: 27017
```

* apply and run (new service will be created)

```sh
kubectl describe service mongodb-service // Endpoints: 172.17.0.2:27017; 
kubectl get pod mongodb-deployment-844789cd64-n8dhf -o wide // IP: 172.17.0.2
```

#### mongo-configmap.yaml

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: mongodb-configmap
data:
  database_url: mongodb-service
```

* apply and run

```sh
kubectl apply -f mongo-configmap.yaml
kubectl get configmap
```

#### mongoexpress-deployment.yaml

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mongoexpress-deployment
  labels:
    app: mongoexpress
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongoexpress
  template:
    metadata:
      labels:
        app: mongoexpress
    spec:
      containers:
      - name: mongoexpress
        image: mongo-express
        ports:
        - containerPort: 8081
        env:
        - name: ME_CONFIG_MONGODB_ADMINUSERNAME
          valueFrom: 
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-username
        - name: ME_CONFIG_MONGODB_ADMINPASSWORD
          valueFrom: 
            secretKeyRef:
              name: mongodb-secret
              key: mongo-root-password
        - name: ME_CONFIG_MONGODB_SERVER
          valueFrom: 
            configMapKeyRef:
              name: mongodb-configmap
              key: database_url
```

* apply and run

#### mongoexpress-service (external)

* `type: LoadBalancer` will be assign with extenal ip
* `nodePort: 30000` (30000 - 32767)

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: mongoexpress-service
spec:
  selector:
    app: mongoexpress
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 8081
      targetPort: 8081
      nodePort: 30000
```

* apply and run

```sh
kubectl apply -f mongoexpress-deployment.yaml
kubectl get services -o wide // EXTERNAL-IP will be pending
```

#### assign external service with public ip

* 01:46:10
* imstall mobaxterm (with X-Server)

```sh
minikube service mongoexpress-service // a new browser will be open @ http://192.168.49.2:30000
```

### <https://minikube.sigs.k8s.io/docs/start/>

* not for production used
* only 1 node will be created in the cluster
* install `minikube`(lightweight verison of k8s)

#### ubuntu

```sh
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
sudo usermod -aG docker $USER && newgrp docker
sudo sysctl fs.protected_regular=0
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker ${USER}
minikube start // start `minikube` as docker container
minikube version
minikube kubectl -- get pods -A // install kubectl
alias kubectl="minikube kubectl --" // create convenient alias
```

* launch dashboard(start another terminal). dashboard will close after you close this terminal

```sh
minikube dashboard
```

* create sample app

```sh
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4 // create deployment from image
kubectl expose deployment hello-minikube --type=NodePort --port=8080 // expose app to port 8080
minikube service hello-minikube // launch in browser
kubectl port-forward service/hello-minikube 7080:8080 // forward to localhost:7080. closing terminal will cancel the port forwarding
```

#### windows

* install and set as PATH

```ps1
New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe' -UseBasicParsing
$oldPath = [Environment]::GetEnvironmentVariable('Path', [EnvironmentVariableTarget]::Machine)
if ($oldPath.Split(';') -inotcontains 'C:\minikube'){ `
  [Environment]::SetEnvironmentVariable('Path', $('{0};C:\minikube' -f $oldPath), [EnvironmentVariableTarget]::Machine) `
}
```

* open a new terminal

```ps1
minikube version
minikube start --driver=virtualbox
```

#### uninstall

##### ubuntu

<https://stackoverflow.com/questions/66016567/how-to-uninstall-minikube-from-ubuntu-i-get-an-unable-to-load-cached-images-e>

```sh
minikube delete
```

* remove the binary @ `/usr/local/bin/minikube`


## Kubernetes

### installation

#### Ubuntu

<https://linuxconfig.org/how-to-install-kubernetes-on-ubuntu-22-04-jammy-jellyfish-linux>

##### introduction

* this tutorial will create 1 master node, 1 worker node, join worker to master, deploy nginx on k8s

```sh
sudo ufw allow 6443
sudo apt install apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" // add package repo
sudo apt install kubeadm kubelet kubectl kubernetes-cni // install k8s
sudo swapoff -a // k8s cannot function if swap is enable
sudo vi /etc/fstab // comment out "/swapfile" line
sudo hostnamectl set-hostname kubernetes-master
sudo hostnamectl set-hostname kubernetes-worker // make sure all node name is unqie
sudo kubeadm init // initialize master
mkdir -p $HOME/.kube // start cluster
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml // create pod network 
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
kubectl get pods --all-namespaces // check and make sure pod is all running. have to wait util all is "1/1 ... RUNNING"
// sudo kubeadm reset --force
// sudo iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X.
// sudo kubeadm init
```

<https://computingforgeeks.com/deploy-kubernetes-cluster-on-ubuntu-with-kubeadm/>

```sh
sudo ufw allow 6443
sudo apt install apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" // add package repo
sudo apt install kubeadm kubelet kubectl kubernetes-cni // install k8s
sudo swapoff -a // k8s cannot function if swap is enable
sudo vi /etc/fstab // comment out "/swapfile" line
sudo mount -a
free -h
sudo modprobe overlay
sudo modprobe br_netfilter
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
```

##### docker based

<https://jamesdefabia.github.io/docs/getting-started-guides/docker/>
<https://stackoverflow.com/questions/33953254/what-is-hyperkube>

* runs both master and worker on top of docker

###### installation

* find the most stable version from <https://console.cloud.google.com/gcr/images/google-containers/global/hyperkube-amd64>
* set the value to `K8S_VERSION` below

```sh
sudo ufw allow 18080
docker-machine ssh `docker-machine active` -f -N -L "18080:localhost:18080"
export K8S_VERSION=v1.18.5 # $(curl -sS https://storage.googleapis.com/kubernetes-release/release/stable.txt)
export K8S_VERSION=v1.17.9
export K8S_VERSION=v1.16.5
export K8S_VERSION=v1.14.7
export K8S_VERSION=v1.19.0-alpha.0
export K8S_VERSION=v1.2.7
export K8S_VERSION=v1.4.12
export K8S_VERSION=v1.5.3
export K8S_VERSION=v1.6.8 # Error: unknown flag: --config
export K8S_VERSION=v1.7.14 # Error: unknown flag: --config
export ARCH=amd64
sudo docker run \
    --volume=/:/rootfs:ro \
    --volume=/sys:/sys:ro \
    --volume=/var/lib/docker/:/var/lib/docker:rw \
    --volume=/var/lib/kubelet/:/var/lib/kubelet:rw \
    --volume=/var/run:/var/run:rw \
    --net=host \
    --pid=host \
    --privileged \
    gcr.io/google_containers/hyperkube-${ARCH}:${K8S_VERSION} \
    /hyperkube kubelet \
        --containerized \
        --hostname-override=127.0.0.1 \
        --api-servers=http://localhost:18080 \
        --config=/etc/kubernetes/manifests \
        --allow-privileged --v=2
```

##### hosted based

<https://www.cloudsigma.com/how-to-install-and-use-kubernetes-on-ubuntu-20-04/>

* runs both master and worker on different machine

###### uninstall

<https://www.reddit.com/r/Ubuntu/comments/pt3pe6/remove_kubernetes_completely_from_a_ubuntu_server/>

```sh
sudo kubeadm reset --force
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
```

###### reset

```sh
sudo kubeadm reset --force
rm -fr $HOME/.kube
```

###### containerd

<https://www.howtoforge.com/how-to-install-containerd-container-runtime-on-ubuntu-22-04/>

```sh
sudo mkdir -p /etc/containerd/
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo systemctl daemon-reload
sudo systemctl start containerd
sudo systemctl enable containerd
```

###### install

```sh
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni
sudo swapoff -a
sudo vi /etc/fstab # comment out /swapfile
sudo hostnamectl set-hostname kubernetes-master
// sudo hostnamectl set-hostname kubernetes-worker // run this ONLY on worker machone
// exit and come back
lsmod | grep br_netfilter // make sure master and work can talk to each other bridge =1 
// sudo modprobe br_netfilter
// sudo sysctl net.bridge.bridge-nf-call-iptables=1 // set to 1//
```

###### initialze master node

```sh
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 // start master node. join cluster command(to be run on all worker node) will be shown in the last line of the command
// kubeadm join 192.168.1.110:6443 --token ni18ef.97cj6jocx33t1449 \
        --discovery-token-ca-cert-hash sha256:4ae1e24cdbfa7d8e86fd19f65c0762b68971d81e5e4ac566c0b55024f9d3212f
sudo crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a 
sudo netstat -tupln|grep 6443 // make sure 6443 is there. else have to reset
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

###### create pod network

```sh
sudo ufw allow 6443
sudo ufw allow 6443/tcp
// sudo systemctl stop kubelet
// sudo systemctl start kubelet
// strace -eopenat kubectl version
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
kubectl get pods --all-namespaces // all should be `RUNNING`
kubectl get componentstatus // kubectl get cs
```

###### join worker to master node

* in a new window (or new machine)

```sh
sudo hostnamectl set-hostname kubernetes-worker
// refer `kubeadm join` command above with `--ignore-preflight-errors='FileAvailable--etc-kubernetes-kubelet.conf,SystemVerification,Port-10250,FileAvailable--etc-kubernetes-pki-ca.crt'`
kubectl get nodes // should see both `master` and `worker` node
```

###### deploying a service on Kubernetes cluster

```sh
kubectl create deployment nginx --image=nginx
kubectl describe deployment nginx
kubectl create service nodeport nginx --tcp=80:80
kubectl get svc
```

###### delete deployment

```sh
kubectl delete deployment nginx
```

###### troubleshoot

```sh
sudo kubeadm reset --force // reset the cluster(if run on master) or remove workdr from cluster(if run on worker)
sudo rm -fr $HOME/.kube
cd /etc/kubernetes/manifests
sudo systemctl status kubelet - check kubelet is running
sudo journalctl -xeu kubelet - check kubelet is running
sudo crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock ps -a | grep kube | grep -v pause -- list all containers
sudo crictl --runtime-endpoint unix:///var/run/containerd/containerd.sock logs CONTAINERID' -- inspect failed container
```

### kubectl

| cmd                                                          | description                            |
| :----------------------------------------------------------- | :------------------------------------- |
| kubectl get [deployment/pod/service] [-o <wide/yaml>] [NAME] |                                        |
| kubectl describe [<pod/deployment/service> [NAME]]           | kubectl describe deployment nginx-depl |
| kubectl delete [<pod/deployment/service> NAME]               | kubectl delete deployment nginx-depl   |
| kubectl apply -f <yaml>                                      |                                        |
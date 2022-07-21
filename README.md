
# Vagrantfile and Scripts to Automate Kubernetes and TrilioVaut for Kubernetes
## Trilio, inc. https://trilio.io/
## Author: Kevin Jackson, Principal Solutions Architect kevin.jackson <at> trilio <dot> io



## Original Credit
This set of Vagrant scripts is originally based on https://github.com/techiescamp/vagrant-kubeadm-kubernetes - an environment that will prepare you for the CKA, CKAD, CKS or KCNA exams.

More information on the original scripts can be found here as well as exam prep can be found here: https://devopscube.com/kubernetes-cluster-vagrant/

Trilio is not associated with the above company in any way.

## What this wil give you

- A Kubernetes environment that installs the TrilioVault for Kubernetes (TVK) Operator for backup/recovery and migration of apps of Kubernetes deployments and applications.

- Kubernetes 1.23
- 3 Nodes: Master, 2 Worker Nodes
- HostPath CSI Driver
- TrilioVault for Kubernetes 2.10.1

## Asciinema Preview
[![asciicast](https://asciinema.org/a/509999.svg)](https://asciinema.org/a/509999)

## Prerequisites

1. Working Vagrant setup (https://vagrantup.com)
2. Working VirtualBox setup (https://www.virtualbox.org/)
3. At least 8 Gig + RAM workstation as the VMs use 2 vCPUS and 4+ GB RAM

Configure spec of the VMs in the file called Vagrantfile.

## For MAC/Linux Users

Latest version of Virtualbox for Mac/Linux can cause issues because you have to create/edit the /etc/vbox/networks.conf file and add:
<pre>* 0.0.0.0/0 ::/0</pre>

or run below commands

```shell
sudo mkdir -p /etc/vbox/
echo "* 0.0.0.0/0 ::/0" | sudo tee -a /etc/vbox/networks.conf
```

So that the host only networks can be in any range, not just 192.168.56.0/21 as described here:
https://discuss.hashicorp.com/t/vagrant-2-2-18-osx-11-6-cannot-create-private-network/30984/23

## Usage

To provision the cluster, execute the following commands.

```shell
git clone https://github.com/uksysadmin/vagrant-kubernetes-trilio.git
cd vagrant-kubernetes-trilio
vagrant up
```

## Set Kubeconfig file variable to access the Kubernetes cluster from your PC/Mac

```shell
cd vagrant-kubernetes-trilio
cd configs
export KUBECONFIG=$(pwd)/config
```

or you can copy the config file to .kube directory.

```shell
cp config ~/.kube/
```

## Kubernetes Dashboard URL
Run a Proxy in a terminal, then access using the following URL

```shell
kubectl proxy
```

```shell
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=kubernetes-dashboard
```


## Kubernetes login token

To log in to the Kubernetes Dashboard using the URL above, vagrant up will create the admin user token and saves in the configs directory.

```shell
cd vagrant-kubernetes-trilio/configs
cat token
```

## TrilioVault for Kubernetes UI Dashboard
During the default install of TVK, we use a self-created ingress. To access the UI from your desktop you can set up a port-forwarder.
In a terminal, run the following:

```shell
kubectl port-forward --address 0.0.0 svc/k8s-triliovault-ingress-hnginx-controller 8002:80
```

This will allow you to access the TrilioVault for Kubernetes UI from your PC/Mac at the following address:

```shell
http://localhost:8002/
```

## TrilioVault for Kubernetes UI Documentation  
https://docs.trilio.io/kubernetes/management-console-ui/navigating-intro/guided-tours

## To shutdown the cluster,

```shell
vagrant halt
```

## To restart the cluster,

```shell
vagrant up
```

## To destroy the cluster,

```shell
vagrant destroy -f
```


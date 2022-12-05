#!/bin/bash

set -euxo pipefail

echo "Setting up CSI HostPath Driver"

git clone https://github.com/kubernetes-csi/csi-driver-host-path.git
cd csi-driver-host-path


# Create snapshot controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/deploy/kubernetes/snapshot-controller/rbac-snapshot-controller.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/deploy/kubernetes/snapshot-controller/setup-snapshot-controller.yaml

# Apply VolumeSnapshot CRDs
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/master/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml


sleep 1

echo "Deploying CSI HostPath Driver..."

deploy/kubernetes-latest/deploy.sh

echo "Waiting for Containers to start..."
sleep 30
echo "Running some PVC Tests and Snapshots..."

for i in ./examples/csi-storageclass.yaml ./examples/csi-pvc.yaml ./examples/csi-app.yaml /vagrant/scripts/csi-snapshot-v1.yaml
do 
	kubectl apply -f $i
done

kubectl get volumesnapshot
sleep 1
kubectl get volumesnapshotcontent

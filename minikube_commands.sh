minikube -p minikube docker-env --shell powershell | Invoke-Expression

#Using Helm, install an NFS server and provisioner in the cluster.
helm repo add stable https://charts.helm.sh/stable
helm install nfs-server-provisioner stable/nfs-server-provisioner \
    --set storageClass.name=nfs-storage

#Create a Persistent Volume Claim which will bind to a NFS Persistent Volume provisione
kubectl apply -f persistence_volume_claim.yaml

#Create a Deployment with a HTTP server (e.g., apache or nginx). The web content directory should be mounted as a volume using the PVC created in the previous step.
kubectl apply -f server.yaml

#Create a Service associated with the Pod(s) of the HTTP server Deployment
kubectl apply -f service.yaml

#Create a Job which mounts the PVC and copies a sample content through the shared NFS PV
kubectl apply -f job.yaml

# To work service correctly
minikube tunnel



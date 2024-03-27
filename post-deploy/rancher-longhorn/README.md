# Overview

This phase is for deploying Rancher and Longhorn to your k3s cluster.

# Provisioning Rancher & Longhorn

## Prepare cluster
1. Copy server node names into file
    ```
    kubectl get nodes --selector=node-role.kubernetes.io/control-plane=true -o=jsonpath='{.items[*].metadata.name}' > server-nodes.txt
    ```
1. Taint Server Nodes 
    ```
    kubectl taint nodes $(cat server-nodes.txt) CriticalAddonsOnly=true:NoExecute
    ```

## Prep Helm Repos, Namespas, and other configurations
1. Add Rancher Repo
    ```
    helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
    ```
1. Create Rancher namespace
    ```
    kubectl create namespace cattle-system
    ```
1. Install `cert-manager`
    ```
    kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
    ```
1. create `cert-manager` namespace
    ```
    kubectl create namespace cert-manager
    ```
1. Add Jetstack Helm Repo
    ```
    helm repo add jetstack https://charts.jetstack.io
    ```
1. Update Helm Repos
    ```
    helm repo update
    ```

## Install Rancher
1. Install `cert-manager` helm chart
    ```
    helm install \
        cert-manager jetstack/cert-manager \
        --namespace cert-manager \
        --version v1.7.1
    ```
1. validate `cert-manager` rollout
    ```
    kubectl get pods --namespace cert-manager
    ```
1. install `rancher`
    > :exclamation: you cannot have .local for the TLD. Rancher will not finishe the stup within web UI. 

    > If you use a different domain/sub-domain, make sure to use the correct one in the below steps as well!
    ```
    helm install rancher rancher-stable/rancher \
        --namespace cattle-system \
        --set hostname=rancher-dev.mlxsolutions.com
    ```
1. validate `rancher` rollout
    ```
    kubectl -n cattle-system rollout status deploy/rancher
    ```
1. create `rancher` service
    ```
    kubectl apply -f config/rancher-service.yml
    ```
1. Obtain IP address of `rancher` service
    ```
    kubectl get svc --all-namespaces -o wide
    ```
1. Update DNS to route `rancher-dev.mlxsolutions.com` to the IP address
1. Obtain bootstrap password
    ```
    kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'
    ```
1. Navigate to `rancher-dev.mlxsolutions.com`, and go through initalization steps, create new admin account

## Install Longhorn
1. Create new project in `Cluster > Projects/Namespaces > Create Project`
1. Instide of the Rancher GUI, navigate to `Apps > Charts > "Longhorn" > Install`
    1. Install Step 1:
        - Select newly create project
        - Next
    1. Install Step 2:
        - Install
1. set longhorn as default StorageClass in `Storage > StorageClasses`

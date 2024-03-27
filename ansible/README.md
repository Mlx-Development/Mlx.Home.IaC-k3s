# Overview

This folder is a clone of [techno-tim](https://github.com/techno-tim)'s [reopository](https://github.com/techno-tim/k3s-ansible) that is available publicly under the Apache-2.0 license. I _**HIGHTLY**_ recommend giving the repository, and the subsequent doccumentation an overview so you understand what's going on with this portion of the code-base!

# Provisioning k3s

## Prep Ansible Playbook

1. ensure that the file `invintory/my-cluster/hosts.ini` was created by terraform
    - each node should have an IP in that file
    - each IP should have an SSH key set to the key provided it your `$/terraform/*.tfvars` file
1. validate contents of `inventory/mlx-cluster/group_vars/all.yml`
    - ensure version of k3s is as expected (Rancher requires specific versions)
    - ensure `ansible_user` is the same user as in `$/terraform/cloud-init-templates/config_ansible.tftpl` file for the `${ansible-ssh-key}` authorized key ("ansible" if not modified)
    - `system_timezone` is set
    - `flannel_iface` is correct for your template
    - `apiserver_endpoint` is set to the VIP of the control plane (not an IP already taken)
    - `k3s_token` is set to correct token for deployment
    - `metal_lb_ip_range` is set to ip range for services
    - `custom_registries` and `custom_registries_yaml` are set, if needed
1. validate invintory path in `$/ansible/ansible.cfg`

## Run Ansible Playbook

>All of these commands are done inside of this directory

1. Run Ansible Playbook
    ```
    ./deploy.sh
    ```
1. Copy Kubeconfig for user
    ```
    cp kubeconfig ~/.kube/config
    ```
1. Ensure kubectl works (get all nodes)
    ```
    kubectl get nodes
    ```
# Next Steps

Technically, you're done! You now have a k3s cluster up and running with a kubeconfig file to connect to it! If you want some common post-deploy options, go to the `$/post-deploy/` folder and read the README there to see some options

# Changes To Original

1. Converted the `README.md` file to be more for the use case it's working on
1. Created `ansible.cfg` from `ansible.example.cfg` and removed that from .gitignore
1. Created  `invintory/my-cluster` from `invintory/sample`
    - removed `hosts.ini`, as it will be generated from terraform
    - updated `group_vars/all.yml` 
        - roll back `k3s_version` for rancher support
        - update `ansible_user` to match user from cloud-init in terraform
        - updated other small defaults
1. Added to `roles/k3s_agent/tasks/main.yml`
    - Installing `nfs-common` on Worker Nodes to enable Longhorn
    - Installing `open-iscsi` on Worker Nodes to enable Longhorn
    - Enabling `open-iscsi` on Worker Nodes to enable Longhorn
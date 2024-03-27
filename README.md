# Overview

This Repo contains IaC code / information used to deploy kubernetes from "scratch". It uses Terraform to deploy VMs and Ansible to configure those VMs to work together in a HA k3s cluster.

# Motivation

Being an software engineer that builds enterprise kubernetes apps in my day-to-day, I like to play around with my own development, and try things out and get a feel for kubernetes overall. As nice as it would be to be able to shell out enough money to go with a cloud provider, I don't use it for anything other than tinkering, so having a "free" option, using my own hardware, is the way to go.

Now, in my homelab, I personally use XCP-ng as my hypervisor, and, well... I'm stingy with my VMs. If I haven't used a VM or resource in a while, I'll purge it from the system. This will probably continue for a while (until i get enough funds for a true pool of servers and a decent amount of storage), and I don't always use Kubernetes.

This means that I generally build up the cluster, do some shenanagains on it, and then in 3 months, destroy the vms, just to have to build it all again. That... is annoying... so let's automate it!

There's also those long-whishfull aspirations to self-host for some production level items, so builing this out now may come in handy at some point in time!

# Deployment Steps

## High-level flow

1. Configure "deployment machine" / "Command Center"
1. Use Terraform to create VMs 
    - Providers 
        - Xen Orchestra Provider (Current)
        - ProxMox Provider (Future)
    - Backend
        - Local (Current)
        - Azurerm (Current)
        - S3 (Future)
        - gcs (Future)
1. Use Ansible to setup a k3s cluster
1. Optional Post-Deploy steps
    - Install Rancher / Longhorn (Current)
    - Deploy Custom Code / Apps (Future)
        - GitHub Actions
        - ADO Pipelines

## Configure "Deployment Machine"

Your milage may vary here, as you may already have some of these tools/items installed.

Ideally, start with a linux distro. I prefer Debian, sometimes find Ubuntu wotrth while, and don't really touch much else. That doens't mean you cannot use other distros or even operating systems, just know that for this, i'll be following Ubuntu/Debian steps/command

1. Fork the repo and clone your fork
    - Forking allows for you to save your configs on your own repo!!!
1. Install Dependencies
    -  _**- EITHER -**_ review and run the `dep-deb.sh` script if you are using a debian system
        - I'll try and get this up to date
        - Highly recommend reviewing to ensure nothing is weird
    - _**- OR -**_ Install on your own
        - [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
        - If using an Azure backend, [Install Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
        - [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian)
        - [Install NetAddr (if needed)](https://netaddr.readthedocs.io/en/latest/installation.html)
        - [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)
        - [Install helm](https://helm.sh/docs/intro/install/#from-apt-debianubuntu)
1. Finalize Changes
    - Log into Azure CLI (if needed)
        ```
        az login
        ```
    - Make `.kube` folder in home
        ```
        mkdir ~/.kube
        ```
1. Ensure machine has acces to deployment networks
    - network of Xen Orchestra for terraform
    - network of k3s Cluster nodes for Ansible



## Next Steps

Next, navigate to the `$/terraform/` folder and read the README there to get started with deploying the VMs!

# Useful Links / Inspiration / Credits

- [Hansaya's Inspiration Repo](https://github.com/hansaya/xcp-ng-k3s-terraform/tree/main)
- [Terraform XenOrchestra Documentation](https://registry.terraform.io/providers/terra-farm/xenorchestra/latest/docs)
- [Terraform XenOrchestra Walkthrough (semi-old)](https://xen-orchestra.com/blog/virtops1-xen-orchestra-terraform-provider/)
- [Techno-Tim's k3s Ansible](https://docs.technotim.live/posts/k3s-etcd-ansible/)
- [Techno-Tim's Rancher Install](https://docs.technotim.live/posts/rancher-ha-install/)


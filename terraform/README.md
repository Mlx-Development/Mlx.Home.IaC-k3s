# Overview

This "Section" of the code-base is set up for creating the XCP-ng VMs for your Kubernetes Cluster via Terraform with Xen Orchestra.

# Assumptions

This code base doens't completly provision XCP-ng from ABSOLUTE scratch, there are some things that are assumed to have been set up already.

1. You already have a valid install of XCP-ng (or similar) and have a Xen Orchestra instance connected to it.
1. You have an SR and Network already pre-configured.
1. You have a valid linux-based template with Clolud Init.
1. (Optional) You have a valid Azure Storage 

# What this does


# Provisioning VMs

## Prep Terraform

1. Configure Provider Connections
    1. Copy XOA provider configuration file
        ```
        cp .xoa-example .xoa
        ```
    1. Edit/update correct values in `.xoa`
        >NOTE: This is you Xen Orchestra connection details, not your XCP-ng connection details!!!
    1. Set env variables by running
        ```
        eval $(cat .xoa)
        ```
    1. Inside of `provider.tf`
        1. If using wss but using self-signed, make sure that `inscure = true` is set up in the `xenorchestra` provider
        1. Configure the backend `azurerm` if you are using it.
            - If you are, update values & make sure to login via the Azure CLI
            - If not, remove that section.
1. Create new SSH key for ansible
    ```
    ssh-keygen -b 4096 -t rsa -f ~/.ssh/k3s-ansb -C "admin@example.com" -q -N ""
    ```
1. Configure Variables
    1. Create new copy of the .tfvars file
        ```
        cp terraform.example.tfvars terraform.tfvars
        ```
    1. Edit the new `terraform.tfvars` file
## Run Terraform

>All of these commands should be ran from this directory

1. Initalize Terraform
    ```
    terraform init
    ```
1. Run Terraform Plan & review any changes
    ```
    terraform plan -var-file=terraform.dev.tfvars
    ```
1. Run Terrafrom Apply
    ```
    terraform apply -var-file=terraform.dev.tfvars -auto-approve
    ```
1. Wait for new VMs to restart
    - restarting ensures updates are configured
    - cloud config automatically triggers restart
    - check inside of xen orchestra for when nodes are available

# Next Steps

Next, navigate to the `$/ansible/` folder and read the README there to get started with configuring k3s via Ansible!

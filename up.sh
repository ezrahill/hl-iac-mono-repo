#!/bin/bash

# Record the start time of the entire script
script_start_time=$(date +%s)

# Function to calculate and display the duration
display_time() {
    local start_time=$1
    local end_time=$(date +%s)
    local duration=$(( end_time - start_time ))
    echo "Duration: $duration seconds"
    echo ""
}

# STAGE 1: NAVIGATE TO TERRAFORM DIRECTORY
echo "STAGE 1: NAVIGATING TO TERRAFORM DIRECTORY"
stage_start_time=$(date +%s)
cd /Users/ezrahill/Documents/Code/GitHub/hl-iac-mono-repo/terraform
display_time $stage_start_time

# STAGE 2: APPLY TERRAFORM CONFIGURATION
echo "STAGE 2: APPLYING TERRAFORM CONFIGURATION"
stage_start_time=$(date +%s)
# terraform init # TODO: Need to add a check
plan_output=$(terraform plan -target=module.k3s-cluster -detailed-exitcode)
if echo "$plan_output" | grep -q 'No changes'; then
    echo "No changes detected."
else
    echo "Terraform has detected changes."
    terraform apply -target=module.k3s-cluster -auto-approve
    echo "Sleeping for 1 minute to allow the k3s cluster to fully initialize..."
    sleep 60
fi
display_time $stage_start_time

# STAGE 3: NAVIGATE TO ANSIBLE DIRECTORY
echo "STAGE 3: NAVIGATING TO ANSIBLE DIRECTORY"
stage_start_time=$(date +%s)
cd ../ansible/k3s
pwd
display_time $stage_start_time

# STAGE 4: ACTIVATE PYTHON VIRTUAL ENVIRONMENT
echo "STAGE 4: ACTIVATING PYTHON VIRTUAL ENVIRONMENT"
stage_start_time=$(date +%s)
# python -m vene .venv  # TODO: Need to create a python virtual environment
# pip install -r requirements.txt  # TODO: Install python dependancies
# ansible-galaxy collection install -r ./collections/requirements.yaml  # TODO: Install ansible dependancies
source .venv/bin/activate
display_time $stage_start_time

# STAGE 5: RUN ANSIBLE PLAYBOOK FOR K3S SETUP
echo "STAGE 5: RUNNING ANSIBLE PLAYBOOK FOR K3S SETUP"
stage_start_time=$(date +%s)
ansible-playbook site.yaml -i inventory/k3s-cluster/hosts.ini -vvv
display_time $stage_start_time

# STAGE 6: DISPLAY CREDENTIALS
echo "STAGE 6: DISPLAYING CREDENTIALS"
stage_start_time=$(date +%s)
echo ""
echo "ArgoCD Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | tr -d '\n')"
echo "Grafana User: $(kubectl -n monitoring get secret grafana -o jsonpath="{.data.admin-user}" | base64 -d | tr -d '\n')"
echo "Grafana Password: $(kubectl -n monitoring get secret grafana -o jsonpath="{.data.admin-password}" | base64 -d | tr -d '\n')"
display_time $stage_start_time

# Display the total script execution time
script_end_time=$(date +%s)
total_duration=$(( script_end_time - script_start_time ))
echo "Total Script Execution Time: $total_duration seconds"
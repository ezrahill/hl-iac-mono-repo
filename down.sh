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
terraform destroy -target=module.k3s-cluster -auto-approve
display_time $stage_start_time

# Display the total script execution time
script_end_time=$(date +%s)
total_duration=$(( script_end_time - script_start_time ))
echo "Total Script Execution Time: $total_duration seconds"
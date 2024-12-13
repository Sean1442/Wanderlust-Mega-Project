#!/bin/bash

# Set the Instance ID and path to the .env file
#INSTANCE_ID="i-030da7d31a1dbbffc"

# Retrieve the public IP address of the specified EC2 instance
#ipv4_address=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

# Path to the .env file
#file_to_find="../frontend/.env.docker"

# Check the current VITE_API_PATH in the .env file
#current_url=$(cat $file_to_find)

# Update the .env file if the IP address has changed
#if [[ "$current_url" != "VITE_API_PATH=\"http://${ipv4_address}:31100\"" ]]; then
    #if [ -f $file_to_find ]; then
        #sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${ipv4_address}:31100\"|g" $file_to_find
    #else
        #echo "ERROR: File not found."
    #fi
#fi

#!/bin/bash

# Set Minikube IP
minikube_ip="192.168.49.2"

# Port for the service
port="31100"

# Path to the .env file
file_to_find="../frontend/.env.docker"

# Desired VITE_API_PATH
new_url="VITE_API_PATH=\"http://${minikube_ip}:${port}\""

# Check if the .env file exists
if [[ ! -f $file_to_find ]]; then
    echo "ERROR: .env file not found at $file_to_find."
    exit 1
fi

# Extract the current VITE_API_PATH from the .env file
current_url=$(grep -E "^VITE_API_PATH=" $file_to_find | cut -d '=' -f 2)

# Update the .env file if the URL has changed
if [[ "$current_url" != "\"http://${minikube_ip}:${port}\"" ]]; then
    sed -i '' -e "s|^VITE_API_PATH=.*|$new_url|g" $file_to_find
    echo "Updated VITE_API_PATH to $new_url in $file_to_find."
else
    echo "VITE_API_PATH is already up-to-date."
fi


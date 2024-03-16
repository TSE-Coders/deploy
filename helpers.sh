INVENTORY_LOCATION="../ansible/inventory"

create_instance() {
    echo "Creating the EC2 Instance: In Progress..."
    pushd tools/terraform > /dev/null
 

    terraform init
    terraform apply -auto-approve

    EC2_IP=$(cat terraform.tfstate | jq -r ".outputs.ec2_ip.value")

    if ! [ -f $INVENTORY_LOCATION ]
    then
        touch $INVENTORY_LOCATION
    fi

    echo $EC2_IP > $INVENTORY_LOCATION

    popd > /dev/null
    echo "Creating the EC2 Instance: Complete"
}

create_sshkey() {
    echo "Creating a temp ssh key for the EC2: In Progress..."
    rm tools/ssh/*
    ssh-keygen -t ed25519 -f "tools/ssh/ec2" -N "" > /dev/null
    echo "Creating a temp ssh key for the EC2: Complete"
}

verify_connection() {
    echo "Verifing the connection to the EC2 via SSH: In Progress..."
    pushd tools/ansible > /dev/null
    ansible all -m ping
    popd > /dev/null
    echo "Verifing the connection to the EC2 via SSH: Complete"
}

update_ec2() {
    echo "Updating the EC2 APT Cache: In Progress..."
    pushd tools/ansible > /dev/null
    ansible-playbook playbook/update.yaml
    popd > /dev/null
    echo "Updating the EC2 APT Cache: Complete"
}

clone_project() {
    echo "Cloning Project Component $1: In Progress..."
    pushd tools/ansible > /dev/null
    ansible-playbook playbook/clone_repo.yaml --extra-vars "component=$1 repo=$2 branch=$3"
    popd > /dev/null
    echo "Cloning Project Component $1: Complete"
}


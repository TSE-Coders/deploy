#!/bin/sh

source helpers.sh

set -e

# # # Script Variables # # #
FRONTEND_REPO="https://github.com/TSE-Coders/pd-client-service.git"
BACKEND_REPO="https://github.com/TSE-Coders/pd-users-api.git"
PRODUCER_REPO="https://github.com/TSE-Coders/ZD.git"
# # # 

create_sshkey 
create_instance 
verify_connection
update_ec2

echo "Cloning Project Components: In Progress..."
clone_project "frontend" $FRONTEND_REPO "autodeployment"
clone_project "backend"  $BACKEND_REPO  "autodeployment"
clone_project "producer" $PRODUCER_REPO "autodeployment"
echo "Cloning Project Components: Complete"

echo "Running the Project Components: In Progress..."
pushd tools/ansible > /dev/null
ansible-playbook playbook/copy_env.yaml --extra-vars "component=producer"
ansible-playbook playbook/run_service.yaml --extra-vars "repo_location=producer"
ansible-playbook playbook/run_service.yaml --extra-vars "repo_location=backend"
ansible-playbook playbook/run_service.yaml --extra-vars "repo_location=frontend"
popd > /dev/null
echo "Running the Project Components: Complete"


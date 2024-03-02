#!/bin/sh

set -e


pushd tools/terraform > /dev/null
echo "Destroying Infrastructure: In Progress..."
terraform destroy -auto-approve > /dev/null
echo "Destroying Infrastructure: Complete"
popd > /dev/null


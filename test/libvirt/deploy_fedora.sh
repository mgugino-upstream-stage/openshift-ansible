#!/bin/bash
#. installrc
set -e
./generate_assets_fedora.sh
./terraform_provision.sh
exit 0
echo "sleeping 20"
sleep 20
openshift-install create ignition-configs
# ./run_ansible.sh

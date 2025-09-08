#!/bin/bash

BASE_DIR="/opt/ansible"

echo "Creating base directory at $BASE_DIR"

mkdir -p "$BASE_DIR"/{inventory,group_vars,templates,files}

# Playbook folders
mkdir -p "$BASE_DIR"/playbooks/{windows,linux,firewall,shared}

# Roles for modular tasks
mkdir -p "$BASE_DIR"/roles/{windows_vm,linux_vm,firewall_vm}

# Role subdirectories
for role in windows_vm linux_vm firewall_vm; do
  mkdir -p "$BASE_DIR/roles/$role"/{tasks,templates}
done

# Create sample files
touch "$BASE_DIR"/inventory/hosts.ini
touch "$BASE_DIR"/group_vars/{all.yml,windows.yml,linux.yml,firewall.yml}
touch "$BASE_DIR"/playbooks/{dispatcher.yml,windows/create_vm_windows.yml,linux/create_vm_linux.yml,firewall/create_vm_firewall.yml}
touch "$BASE_DIR"/playbooks/shared/{vars.yml,resolve_iso.yml,create_vm_base.yml,summary_output.yml,validate_inputs.yml}
touch "$BASE_DIR"/templates/vm_summary.csv.j2
touch "$BASE_DIR"/files/.gitkeep

echo "✅ Folder structure created at: $BASE_DIR"

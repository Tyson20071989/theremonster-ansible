#!/usr/bin/env bash
set -euo pipefail

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

ANSIBLE_DIR="/opt/ansible"

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "ansible-playbook not found in PATH." >&2
  exit 1
fi

echo
echo "Select workload type:"
select TYPE in "Linux" "Windows" "Firewall" "Destroy VM" "Quit"; do
  case "$TYPE" in
    "Linux")
      PLAYBOOK="playbooks/linux/create_vm_linux.yml"
      break
      ;;
    "Windows")
      PLAYBOOK="playbooks/windows/create_vm_windows.yml"
      break
      ;;
    "Firewall")
      PLAYBOOK="playbooks/firewall/create_vm_firewall.yml"
      break
      ;;
    "Destroy VM")
      PLAYBOOK="playbooks/shared/destroy_proxmox.yml"
      break
      ;;
    "Quit")
      exit 0
      ;;
    *)
      echo "Invalid selection. Try again."
      ;;
  esac
done

echo
echo "Launching: $PLAYBOOK"
export ANSIBLE_REMOTE_USER="${ANSIBLE_REMOTE_USER:-root}"
# Optional: skip host key prompts (or pre-populate known_hosts)
# export ANSIBLE_HOST_KEY_CHECKING=False

cd "$ANSIBLE_DIR"
ansible-playbook "$PLAYBOOK" "$@"

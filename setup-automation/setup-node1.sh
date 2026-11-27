#!/bin/bash
set -eu
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

# Passwordless sudo so the rhel user can run oscap / autotailor / composer-cli
# non-interactively on node1. node1 is NOT CIS-remediated by the lab, so this
# NOPASSWD drop-in persists for the whole lab.
echo 'rhel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/rhel-nopasswd
chmod 0440 /etc/sudoers.d/rhel-nopasswd

echo "Setup vm node1" > /tmp/progress.log
chmod 666 /tmp/progress.log

# --- Working directories for scan reports/results/blueprints (root used after `sudo -i`) ---
mkdir -p /home/rhel/compliance
chown rhel:rhel /home/rhel/compliance
mkdir -p /root/compliance

# --- Authorize the throwaway lab key so rhel (and root@rhel) can SSH in ---
LAB_PUBKEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDchtSYcBieD9IGF3V33pfdWrUpx6EbZfJ6rrK4F0IRb zt-security-compliance-lab-key'

authorize_key() {
  home="$1"; owner="$2"
  mkdir -p "$home/.ssh"
  touch "$home/.ssh/authorized_keys"
  grep -qF "$LAB_PUBKEY" "$home/.ssh/authorized_keys" || echo "$LAB_PUBKEY" >> "$home/.ssh/authorized_keys"
  chmod 700 "$home/.ssh"
  chmod 600 "$home/.ssh/authorized_keys"
  chown -R "$owner" "$home/.ssh"
}
authorize_key /home/rhel rhel:rhel
authorize_key /root root:root

# The runner reaches node1 over SSH. Do not restart its SSH transport.
systemctl is-active --quiet sshd

# The learner installs and starts Image Builder in module 7. Only stage its
# Satellite repository configuration here.

# The Lab environment is connected to an internal Red Hat Demo Platform Satellite server (demosat-ha.infra.demo.redhat.com) using Red Hat Subscription Manager (rhsm) certificates, rather than cdn.redhat.com.
# Run these commands to write the exact repository override file pointing to your lab's Satellite URLs \
# (keeping "rhsm": true so osbuild-composer uses your existing Satellite entitlement certificates).

mkdir -p /etc/osbuild-composer/repositories

cat > /etc/osbuild-composer/repositories/rhel-10.1.json << 'EOF'
{
  "x86_64": [
    {
      "name": "baseos",
      "baseurl": "https://demosat-ha.infra.demo.redhat.com/pulp/repos/Red_Hat_RHDP_Labs/Library/zt-rhelbu/content/dist/rhel10/10/x86_64/baseos/os",
      "rhsm": true,
      "check_gpg": false
    },
    {
      "name": "appstream",
      "baseurl": "https://demosat-ha.infra.demo.redhat.com/pulp/repos/Red_Hat_RHDP_Labs/Library/zt-rhelbu/content/dist/rhel10/10/x86_64/appstream/os",
      "rhsm": true,
      "check_gpg": false
    },
    {
      "name": "codeready-builder",
      "baseurl": "https://demosat-ha.infra.demo.redhat.com/pulp/repos/Red_Hat_RHDP_Labs/Library/zt-rhelbu/content/dist/rhel10/10/x86_64/codeready-builder/os",
      "rhsm": true,
      "check_gpg": false
    }
  ]
}
EOF

echo "Lab setup complete" >> /tmp/progress.log
exit 0

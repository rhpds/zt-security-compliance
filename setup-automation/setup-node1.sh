#!/bin/bash
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

systemctl enable --now sshd

# --- Red Hat Image Builder (osbuild-composer) for module-07 ---
# composer-cli talks to osbuild-composer over its socket; enable it now so the
# participant's first `composer-cli` call works without a cold-start wait.
systemctl enable --now osbuild-composer.socket

echo "Lab setup complete" >> /tmp/progress.log
exit 0

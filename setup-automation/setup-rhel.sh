#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

# Passwordless sudo for the lab user (needed for non-interactive sudo in scripts
# and so the participant can `sudo -i` before hardening). NOTE: the CIS remediation
# the participant runs in module-04 intentionally strips NOPASSWD from this box —
# that is expected. The participant becomes root (`sudo -i`) at the start of the
# hardening modules, and all solve/validation scripts run as root via Ansible
# become, so neither depends on NOPASSWD surviving remediation.
echo 'rhel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/rhel-nopasswd
chmod 0440 /etc/sudoers.d/rhel-nopasswd

echo "Setup vm rhel" > /tmp/progress.log
chmod 666 /tmp/progress.log

# --- Working directories for scan reports/results (root is used after `sudo -i`) ---
mkdir -p /home/rhel/compliance
chown rhel:rhel /home/rhel/compliance
mkdir -p /root/compliance

# --- Self-contained rhel -> node1 SSH using a throwaway, lab-only keypair ---
# (matched by the public key installed on node1 in setup-node1.sh). Installed for
# BOTH the rhel user and root so that root-context validation scripts can reach
# node1 as root without needing sudo on node1 (which CIS remediation could strip).
install_rhel_key() {
  home="$1"; owner="$2"; sshuser="$3"
  mkdir -p "$home/.ssh"
  cat > "$home/.ssh/id_ed25519" << 'KEYEOF'
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACA3IbUmHAYng/SBhd1d96X3Vq1KcehG2Xyeq6yuBdCEWwAAAKgofTEWKH0x
FgAAAAtzc2gtZWQyNTUxOQAAACA3IbUmHAYng/SBhd1d96X3Vq1KcehG2Xyeq6yuBdCEWw
AAAEAyRJJkGtjOAkluR3Gl891Bj5sI3C+ozErII4Smu5UDTTchtSYcBieD9IGF3V33pfdW
rUpx6EbZfJ6rrK4F0IRbAAAAHnp0LXNlY3VyaXR5LWNvbXBsaWFuY2UtbGFiLWtleQECAw
QFBgc=
-----END OPENSSH PRIVATE KEY-----
KEYEOF
  cat > "$home/.ssh/id_ed25519.pub" << 'PUBEOF'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDchtSYcBieD9IGF3V33pfdWrUpx6EbZfJ6rrK4F0IRb zt-security-compliance-lab-key
PUBEOF
  cat > "$home/.ssh/config" << CFGEOF
Host node1
    HostName node1
    User $sshuser
    IdentityFile $home/.ssh/id_ed25519
    StrictHostKeyChecking accept-new
CFGEOF
  chmod 700 "$home/.ssh"
  chmod 600 "$home/.ssh/id_ed25519" "$home/.ssh/config"
  chmod 644 "$home/.ssh/id_ed25519.pub"
  chown -R "$owner" "$home/.ssh"
}
install_rhel_key /home/rhel rhel:rhel rhel
install_rhel_key /root root:root root

# node1 hostname resolution: prefer platform-provided DNS. If the platform exposes
# node1's address via NODE1_IP (see setup-automation/main.yml), pin it in /etc/hosts.
if [ -n "${NODE1_IP}" ] && ! getent hosts node1 >/dev/null 2>&1; then
  echo "${NODE1_IP} node1" >> /etc/hosts
fi

echo "Lab setup complete" >> /tmp/progress.log
exit 0

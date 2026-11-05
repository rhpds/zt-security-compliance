#!/bin/sh
echo "Solving module-02" >> /tmp/progress.log

# Participant commands for module-02 (vulnerability & patch management). These run
# as root. dnf's updateinfo subcommand is the supported way to enumerate CVEs and
# security errata on RHEL 10 (the OVAL vulnerability feed is retired on RHEL 10).

echo "--- Security errata summary ---"
dnf -y updateinfo summary 2>/dev/null || true

echo "--- Outstanding security advisories ---"
dnf -y updateinfo list --security 2>/dev/null || true

echo "--- Same gap expressed as CVE IDs ---"
dnf -y updateinfo list --cves 2>/dev/null || true

echo "--- Applying all outstanding SECURITY updates ---"
# Apply security updates only. Tolerate exit codes when there is nothing to do or
# when metadata is unavailable (e.g. an unsubscribed lab image).
dnf -y --security update 2>/dev/null || true

echo "--- Re-check: outstanding security advisories after patching ---"
dnf -y updateinfo list --security 2>/dev/null || true

echo "Solved module-02" >> /tmp/progress.log
exit 0

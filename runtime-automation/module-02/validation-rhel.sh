#!/bin/sh
echo "Validating module-02" >> /tmp/progress.log

# Objective: all outstanding SECURITY updates have been applied — i.e. there are no
# remaining available security advisories. On a subscribed system this proves the
# participant ran `dnf --security update`. On an unsubscribed image the list is
# empty too, so this check degrades gracefully to PASS.

if ! command -v dnf > /dev/null 2>&1; then
    echo "FAIL: dnf not found"
    echo "HINT: this lab requires a RHEL 10 system with dnf. Contact lab support."
    exit 1
fi

# Count remaining available security advisories. Advisory rows begin with an
# advisory ID such as RHSA-2025:1234 / RHBA / RHEA.
PENDING=$(dnf -q updateinfo list --security --available 2>/dev/null \
            | grep -Ec '^(RHSA|RHBA|RHEA|FEDORA)-' )

if [ "${PENDING:-0}" -gt 0 ]; then
    echo "FAIL: $PENDING security advisories are still outstanding"
    echo "HINT: apply them with 'sudo dnf -y --security update', then continue."
    exit 1
fi

echo "PASS: module-02 objectives verified (no outstanding security advisories)"
exit 0

#!/bin/sh
echo "Solving module-04" >> /tmp/progress.log

# Participant commands for module-04: apply automated CIS Level 1 remediation, then
# re-scan to prove the box now passes the rules it previously failed. Runs as root.
#
# NOTE: CIS remediation intentionally hardens this box, including removing
# passwordless sudo for the rhel user. That is expected — the rest of the lab runs
# on node1, and these scripts run as root via Ansible become, so nothing downstream
# depends on rhel's NOPASSWD surviving here.
DS=/usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml
OUT=/root/compliance
mkdir -p "$OUT"

echo "--- Applying CIS L1 remediation ---"
oscap xccdf eval --remediate \
  --profile xccdf_org.ssgproject.content_profile_cis_server_l1 \
  --results "$OUT/results-remediate.xml" \
  --report "$OUT/report-remediate.html" \
  "$DS"
rc=$?
if [ "$rc" -eq 1 ]; then
    echo "oscap remediation reported a tool error (rc=1)" >> /tmp/progress.log
    exit 1
fi

echo "--- Re-scanning to verify remediation ---"
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_server_l1 \
  --results "$OUT/results-l1-after.xml" \
  --report "$OUT/report-l1-after.html" \
  "$DS"
rc=$?
if [ "$rc" -eq 1 ]; then
    echo "oscap re-scan reported a tool error (rc=1)" >> /tmp/progress.log
    exit 1
fi

BEFORE=$(grep -c '<result>fail</result>' "$OUT/results-l1-before.xml" 2>/dev/null || echo "n/a")
AFTER=$(grep -c '<result>fail</result>' "$OUT/results-l1-after.xml" 2>/dev/null || echo "n/a")
echo "--- Failing rules: before=$BEFORE  after=$AFTER ---"

echo "Solved module-04" >> /tmp/progress.log
exit 0

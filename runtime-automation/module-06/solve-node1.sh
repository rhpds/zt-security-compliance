#!/bin/sh
echo "Solving module-06" >> /tmp/progress.log

# Participant commands for module-06, performed ON node1: create an operational
# exception with autotailor (a tailoring file that derives a custom profile from
# CIS L1 and unselects one rule) WITHOUT editing the vendor datastream, then scan
# with the custom profile. Runs as root.
#
# Operational exception example: the shell idle-timeout rule (accounts_tmout) logs
# admins out of long-running console sessions, so Super-Business waives it.
DS=/usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml
OUT=/root/compliance
mkdir -p "$OUT"

echo "--- Building the tailoring file with autotailor ---"
autotailor \
  --output "$OUT/tailoring-cis-l1-custom.xml" \
  --new-profile-id xccdf_org.ssgproject.content_profile_cis_server_l1_custom \
  --title "CIS L1 Server - Super-Business custom" \
  --unselect xccdf_org.ssgproject.content_rule_accounts_tmout \
  "$DS" \
  xccdf_org.ssgproject.content_profile_cis_server_l1
rc=$?
if [ "$rc" -ne 0 ]; then
    echo "autotailor failed (rc=$rc)" >> /tmp/progress.log
    exit 1
fi

echo "--- The vendor datastream is untouched; the override lives only in the tailoring file ---"
grep -A1 "accounts_tmout" "$OUT/tailoring-cis-l1-custom.xml" | head -n 4

echo "--- Scanning with the custom (tailored) profile ---"
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_server_l1_custom \
  --tailoring-file "$OUT/tailoring-cis-l1-custom.xml" \
  --results "$OUT/results-custom.xml" \
  --report "$OUT/report-custom.html" \
  "$DS"
[ "$?" -eq 1 ] && { echo "oscap tailored scan tool error" >> /tmp/progress.log; exit 1; }

echo "Solved module-06" >> /tmp/progress.log
exit 0

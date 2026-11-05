#!/bin/sh
echo "Solving module-03" >> /tmp/progress.log

# Participant commands for module-03: run an out-of-the-box CIS Level 1 (Server)
# audit and save the machine-readable results + the human-readable HTML report.
# Runs as root.
DS=/usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml
OUT=/root/compliance
mkdir -p "$OUT"

# oscap returns 2 when at least one rule fails (expected on an un-hardened box);
# only 1 is a real tool error. Guard so a normal "failed rules" run is success.
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_server_l1 \
  --results "$OUT/results-l1-before.xml" \
  --report "$OUT/report-l1-before.html" \
  "$DS"
rc=$?
if [ "$rc" -eq 1 ]; then
    echo "oscap reported a tool error (rc=1)" >> /tmp/progress.log
    exit 1
fi

echo "--- Baseline CIS L1 result: pass vs fail counts ---"
echo "pass: $(grep -c '<result>pass</result>' "$OUT/results-l1-before.xml")"
echo "fail: $(grep -c '<result>fail</result>' "$OUT/results-l1-before.xml")"

echo "Solved module-03" >> /tmp/progress.log
exit 0

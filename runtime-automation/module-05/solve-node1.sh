#!/bin/sh
echo "Solving module-05" >> /tmp/progress.log

# Participant commands for module-05, performed ON node1: audit the fresh box with
# CIS Level 2 (Server) and contrast it with CIS Level 1 to see how many more rules
# the maximum-security profile selects. Runs as root.
DS=/usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml
OUT=/root/compliance
mkdir -p "$OUT"

echo "--- CIS Level 1 (Server) audit on node1 ---"
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis_server_l1 \
  --results "$OUT/results-l1-node1.xml" \
  --report "$OUT/report-l1-node1.html" \
  "$DS"
[ "$?" -eq 1 ] && { echo "oscap L1 tool error" >> /tmp/progress.log; exit 1; }

echo "--- CIS Level 2 (Server) audit on node1 ---"
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_cis \
  --results "$OUT/results-l2.xml" \
  --report "$OUT/report-l2.html" \
  "$DS"
[ "$?" -eq 1 ] && { echo "oscap L2 tool error" >> /tmp/progress.log; exit 1; }

L1=$(grep -c '<rule-result' "$OUT/results-l1-node1.xml")
L2=$(grep -c '<rule-result' "$OUT/results-l2.xml")
echo "--- Rules evaluated: CIS L1=$L1   CIS L2=$L2  (L2 selects more) ---"

echo "Solved module-05" >> /tmp/progress.log
exit 0

#!/bin/sh
echo "Validating module-05" >> /tmp/progress.log

# Objective: on node1, the participant ran a CIS Level 2 audit and a CIS Level 1
# audit, and the L2 profile evaluated more rules than L1 (standard vs. maximum).
OUT=/root/compliance

if [ ! -f "$OUT/results-l2.xml" ]; then
    echo "FAIL: CIS Level 2 results not found on node1 ($OUT/results-l2.xml)"
    echo "HINT: run the L2 audit on node1:"
    echo "      sudo oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_cis \\"
    echo "        --results ~/compliance/results-l2.xml --report ~/compliance/report-l2.html \\"
    echo "        /usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml"
    exit 1
fi

# Confirm the results came from the L2 'cis' profile and not the L1 profile.
if ! grep -q 'content_profile_cis"' "$OUT/results-l2.xml" 2>/dev/null; then
    echo "FAIL: results-l2.xml is not from the CIS Level 2 Server profile"
    echo "HINT: the L2 profile id is xccdf_org.ssgproject.content_profile_cis (no _server_l1 suffix)."
    exit 1
fi

if [ ! -f "$OUT/results-l1-node1.xml" ]; then
    echo "FAIL: CIS Level 1 comparison results not found on node1 ($OUT/results-l1-node1.xml)"
    echo "HINT: also run the L1 audit on node1 so you can compare L1 vs L2."
    exit 1
fi

L1=$(grep -c '<rule-result' "$OUT/results-l1-node1.xml" 2>/dev/null)
L2=$(grep -c '<rule-result' "$OUT/results-l2.xml" 2>/dev/null)

if [ "${L2:-0}" -le "${L1:-0}" ]; then
    echo "FAIL: CIS L2 did not evaluate more rules than L1 (L1=$L1, L2=$L2)"
    echo "HINT: ensure the L2 scan used --profile ...content_profile_cis against ssg-rhel10-ds.xml."
    exit 1
fi

echo "PASS: module-05 objectives verified (L2 evaluated $L2 rules vs L1 $L1)"
exit 0

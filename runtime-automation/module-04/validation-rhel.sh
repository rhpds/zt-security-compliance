#!/bin/sh
echo "Validating module-04" >> /tmp/progress.log

# Objective: automated CIS L1 remediation ran and measurably reduced the number of
# failing rules compared to the module-03 baseline.
OUT=/root/compliance

if [ ! -f "$OUT/results-remediate.xml" ]; then
    echo "FAIL: remediation results not found ($OUT/results-remediate.xml)"
    echo "HINT: run the remediation from module-04:"
    echo "      sudo oscap xccdf eval --remediate --profile xccdf_org.ssgproject.content_profile_cis_server_l1 \\"
    echo "        --results ~/compliance/results-remediate.xml --report ~/compliance/report-remediate.html \\"
    echo "        /usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml"
    exit 1
fi

if [ ! -f "$OUT/results-l1-after.xml" ]; then
    echo "FAIL: post-remediation scan results not found ($OUT/results-l1-after.xml)"
    echo "HINT: after remediating, re-scan into ~/compliance/results-l1-after.xml"
    exit 1
fi

if [ ! -f "$OUT/results-l1-before.xml" ]; then
    echo "FAIL: baseline results from module-03 not found ($OUT/results-l1-before.xml)"
    echo "HINT: go back to module-03 and run the baseline scan first."
    exit 1
fi

BEFORE=$(grep -c '<result>fail</result>' "$OUT/results-l1-before.xml" 2>/dev/null)
AFTER=$(grep -c '<result>fail</result>' "$OUT/results-l1-after.xml" 2>/dev/null)

if [ "${AFTER:-0}" -ge "${BEFORE:-0}" ]; then
    echo "FAIL: remediation did not reduce failing rules (before=$BEFORE, after=$AFTER)"
    echo "HINT: ensure you ran oscap with --remediate and then re-scanned the same profile."
    exit 1
fi

echo "PASS: module-04 objectives verified (failing rules dropped from $BEFORE to $AFTER)"
exit 0

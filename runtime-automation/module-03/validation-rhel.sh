#!/bin/sh
echo "Validating module-03" >> /tmp/progress.log

# Objective: the participant ran a CIS Level 1 (Server) baseline scan and produced
# a results file and an HTML report.
OUT=/root/compliance

if [ ! -f "$OUT/results-l1-before.xml" ]; then
    echo "FAIL: baseline results file not found ($OUT/results-l1-before.xml)"
    echo "HINT: run the CIS L1 scan from module-03:"
    echo "      sudo oscap xccdf eval --profile xccdf_org.ssgproject.content_profile_cis_server_l1 \\"
    echo "        --results ~/compliance/results-l1-before.xml --report ~/compliance/report-l1-before.html \\"
    echo "        /usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml"
    exit 1
fi

if [ ! -f "$OUT/report-l1-before.html" ]; then
    echo "FAIL: baseline HTML report not found ($OUT/report-l1-before.html)"
    echo "HINT: include --report ~/compliance/report-l1-before.html in the oscap command."
    exit 1
fi

# The results must come from the CIS L1 profile and contain rule results.
if ! grep -q "cis_server_l1" "$OUT/results-l1-before.xml" 2>/dev/null; then
    echo "FAIL: the results file is not from the CIS Level 1 Server profile"
    echo "HINT: use --profile xccdf_org.ssgproject.content_profile_cis_server_l1"
    exit 1
fi

if ! grep -q "<result>" "$OUT/results-l1-before.xml" 2>/dev/null; then
    echo "FAIL: the results file contains no rule results"
    echo "HINT: re-run the scan; the datastream path must be ssg-rhel10-ds.xml"
    exit 1
fi

echo "PASS: module-03 objectives verified (CIS L1 baseline audit produced)"
exit 0

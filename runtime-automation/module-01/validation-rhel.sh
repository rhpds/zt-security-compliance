#!/bin/sh
echo "Validating module-01" >> /tmp/progress.log

# Objective: confirm this is a RHEL 10 host with the OpenSCAP tooling and the
# SCAP Security Guide content (CIS profiles) available.
DS=/usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml

if ! grep -q "release 10" /etc/redhat-release 2>/dev/null; then
    echo "FAIL: this does not look like a RHEL 10 system"
    echo "HINT: this lab requires Red Hat Enterprise Linux 10. Contact lab support."
    exit 1
fi

if ! command -v oscap > /dev/null 2>&1; then
    echo "FAIL: the 'oscap' scanner is not installed"
    echo "HINT: it is provided by the openscap-scanner package. Contact lab support."
    exit 1
fi

if [ ! -f "$DS" ]; then
    echo "FAIL: the SCAP Security Guide datastream is missing ($DS)"
    echo "HINT: it is provided by the scap-security-guide package. Contact lab support."
    exit 1
fi

if ! oscap info --profiles "$DS" 2>/dev/null | grep -q "cis_server_l1"; then
    echo "FAIL: the CIS Level 1 Server profile was not found in the datastream"
    echo "HINT: expected profile xccdf_org.ssgproject.content_profile_cis_server_l1. Contact lab support."
    exit 1
fi

echo "PASS: module-01 objectives verified (RHEL 10 with OpenSCAP + CIS content)"
exit 0

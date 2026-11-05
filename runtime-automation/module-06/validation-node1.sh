#!/bin/sh
echo "Validating module-06" >> /tmp/progress.log

# Objective: the participant produced an autotailor tailoring file on node1 that
# derives a custom profile from CIS L1 and unselects the accounts_tmout rule, then
# scanned with it — all without modifying the vendor datastream.
OUT=/root/compliance
TF="$OUT/tailoring-cis-l1-custom.xml"
RULE=xccdf_org.ssgproject.content_rule_accounts_tmout

if [ ! -f "$TF" ]; then
    echo "FAIL: tailoring file not found ($TF)"
    echo "HINT: create it on node1 with autotailor (see module-06), using"
    echo "      --new-profile-id ...cis_server_l1_custom and --unselect $RULE"
    exit 1
fi

if ! grep -q "cis_server_l1_custom" "$TF" 2>/dev/null; then
    echo "FAIL: the tailoring file does not define the custom profile"
    echo "HINT: pass --new-profile-id xccdf_org.ssgproject.content_profile_cis_server_l1_custom"
    exit 1
fi

# The waived rule must be present and explicitly unselected in the tailoring file.
if ! grep "$RULE" "$TF" 2>/dev/null | grep -q 'selected="false"'; then
    echo "FAIL: the rule $RULE is not unselected in the tailoring file"
    echo "HINT: add --unselect $RULE to the autotailor command."
    exit 1
fi

# The vendor datastream must NOT have been edited to achieve the exception.
if grep -q 'selected="false"' /usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml 2>/dev/null \
     && grep "$RULE" /usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml 2>/dev/null | grep -q 'selected="false"'; then
    echo "FAIL: the vendor datastream appears to have been modified for the exception"
    echo "HINT: never edit ssg-rhel10-ds.xml; express exceptions only in the tailoring file."
    exit 1
fi

if [ ! -f "$OUT/results-custom.xml" ]; then
    echo "FAIL: no scan results from the custom profile ($OUT/results-custom.xml)"
    echo "HINT: run oscap with --profile ...cis_server_l1_custom --tailoring-file $TF"
    exit 1
fi

echo "PASS: module-06 objectives verified (custom profile waives $RULE via tailoring only)"
exit 0

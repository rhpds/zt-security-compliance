#!/bin/sh
echo "Validating module-07" >> /tmp/progress.log

# Objective: on node1, the participant pushed an Image Builder blueprint that bakes
# the CIS Level 1 compliance profile into the image. We validate the blueprint and
# its compliance customization — not a completed (slow) image build.

if ! command -v composer-cli > /dev/null 2>&1; then
    echo "FAIL: composer-cli not found on node1"
    echo "HINT: it is provided by the composer-cli package. Contact lab support."
    exit 1
fi

if ! systemctl is-active --quiet osbuild-composer.socket; then
    echo "FAIL: osbuild-composer is not available on node1"
    echo "HINT: start it with 'sudo systemctl start osbuild-composer.socket'."
    exit 1
fi

if ! composer-cli blueprints list 2>/dev/null | grep -q "hardened-rhel10"; then
    echo "FAIL: the 'hardened-rhel10' blueprint has not been pushed"
    echo "HINT: create blueprint.toml (see module-07) and run 'sudo composer-cli blueprints push blueprint.toml'."
    exit 1
fi

SHOW=$(composer-cli blueprints show hardened-rhel10 2>/dev/null)

if ! echo "$SHOW" | grep -q "openscap"; then
    echo "FAIL: the blueprint has no [customizations.openscap] section"
    echo "HINT: add an [customizations.openscap] block with datastream and profile_id."
    exit 1
fi

if ! echo "$SHOW" | grep -q "cis_server_l1"; then
    echo "FAIL: the blueprint does not bake in the CIS Level 1 Server profile"
    echo "HINT: set profile_id = \"xccdf_org.ssgproject.content_profile_cis_server_l1\"."
    exit 1
fi

echo "PASS: module-07 objectives verified (blueprint bakes in CIS L1 compliance)"
exit 0

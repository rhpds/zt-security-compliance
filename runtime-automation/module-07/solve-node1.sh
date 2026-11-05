#!/bin/sh
echo "Solving module-07" >> /tmp/progress.log

# Participant commands for module-07, performed ON node1: use Red Hat Image Builder
# (osbuild-composer / composer-cli) to bake a CIS Level 1 compliance profile into an
# image blueprint, so VMs built from it are hardened from first boot. Runs as root.
OUT=/root/compliance
mkdir -p "$OUT"
BP="$OUT/blueprint.toml"

# Make sure the composer API socket is up (also enabled at provision time).
systemctl start osbuild-composer.socket 2>/dev/null || true

echo "--- Writing the compliance-as-code blueprint ---"
cat > "$BP" << 'EOF'
name = "hardened-rhel10"
description = "RHEL 10 image with CIS Level 1 (Server) baked in"
version = "0.0.1"

[customizations.openscap]
datastream = "/usr/share/xml/scap/ssg/content/ssg-rhel10-ds.xml"
profile_id = "xccdf_org.ssgproject.content_profile_cis_server_l1"
EOF

echo "--- Pushing the blueprint to Image Builder ---"
composer-cli blueprints push "$BP"
rc=$?
if [ "$rc" -ne 0 ]; then
    echo "composer-cli blueprints push failed (rc=$rc)" >> /tmp/progress.log
    exit 1
fi

echo "--- The compliance customization is now part of the blueprint ---"
composer-cli blueprints show hardened-rhel10

# Depsolve and starting a build need content repositories and take several minutes;
# attempt them but tolerate failure so the module does not hang or fail offline.
echo "--- Depsolving (optional; needs content repos) ---"
composer-cli blueprints depsolve hardened-rhel10 2>/dev/null || \
  echo "(depsolve skipped/failed — blueprint with the compliance profile is still valid)"

echo "--- Starting a qcow2 build (optional; runs in the background) ---"
composer-cli compose start hardened-rhel10 qcow2 2>/dev/null || \
  echo "(compose start skipped/failed — not required to complete for this lab)"

composer-cli compose status 2>/dev/null || true

echo "Solved module-07" >> /tmp/progress.log
exit 0

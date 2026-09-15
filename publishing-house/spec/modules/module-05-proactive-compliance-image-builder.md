# Module 5: Proactive Compliance with Image Builder (Box 2)

### Brief Overview

The final module shifts from fixing running systems to shipping systems that are compliant from first boot. On Box 2, participants use Red Hat Image Builder (osbuild-composer) to define a blueprint that embeds OpenSCAP directives, then build a pre-hardened RHEL image. The result is a QCOW2 image that already meets the chosen security profile, demonstrating a proactive "shift-left" approach to compliance where hardening is baked into the image rather than applied afterward.

### Audience and Time

- **Personas:** Linux system administrators and security-focused operators, at a beginner level within the guided RH1 series.
- **Prerequisites for this module:** Completion of Modules 1-4 (understanding OpenSCAP profiles, remediation, and tailoring); Red Hat Image Builder (osbuild-composer) tooling available on Box 2.
- **Estimated duration:** 8 min

### Learning Objectives

- Build a pre-hardened RHEL image with Red Hat Image Builder by embedding OpenSCAP directives into a blueprint.
- Define an Image Builder blueprint that references a chosen OpenSCAP compliance profile.
- Produce a QCOW2 image that is compliant from first boot.

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Prepare Image Builder on Box 2 | 2 min |
| 2 | Author a blueprint with embedded OpenSCAP directives | 3 min |
| 3 | Build the pre-hardened QCOW2 image | 3 min |

### Detailed Steps

1. On Box 2, confirm Red Hat Image Builder (osbuild-composer) and its services are available and running.
2. Create an Image Builder blueprint for a RHEL image.
3. Add OpenSCAP directives to the blueprint that reference the chosen compliance profile (for example, a CIS profile) so hardening is applied during the build.
4. Import or push the blueprint into Image Builder and confirm it is registered.
5. Start a build from the blueprint, requesting a QCOW2 image output.
6. Monitor the build until it completes successfully and locate the resulting QCOW2 image.
7. Explain how the produced image is hardened at build time, so instances launched from it start already aligned with the profile rather than requiring post-deployment remediation.
8. Contrast this proactive approach with the live-remediation workflow from Module 2.

### Key Takeaways

- Red Hat Image Builder can embed OpenSCAP directives directly into a blueprint so hardening happens at build time.
- A pre-hardened QCOW2 image starts compliant from first boot, reducing post-deployment remediation work.
- Building compliance into images is a proactive, shift-left complement to auditing and remediating live systems.

### Infrastructure Notes

- Box 2 must have Red Hat Image Builder (osbuild-composer) tooling and reachable package repositories, and be ready for image builds.
- Module 5 assessment outcome: a pre-hardened QCOW2 image is successfully built from a blueprint containing OpenSCAP directives.

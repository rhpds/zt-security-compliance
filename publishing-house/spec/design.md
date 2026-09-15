# Automated Linux Security Compliance & Hardening

## Overview

This lab teaches the end-to-end workflow that enterprise teams use to measure, enforce, and sustain Linux security compliance. It is Part 3 of 3 in the RH1 Linux security series, building on the foundation established in the earlier parts. Working across two Red Hat Enterprise Linux systems, participants run an OpenSCAP audit against a CIS profile, interpret the compliance report, apply automated remediation, and verify that controls move from Fail to Pass. They then compare CIS Level 1 and Level 2 standards, create custom rule exceptions with `autotailor`, and use Red Hat Image Builder to bake a compliance profile directly into a pre-hardened VM image.

## Target Audience

- **Role:** Linux system administrators and security-focused operators
- **Experience level:** Beginner (within the guided RH1 series; Parts 1–2 provide prerequisite context)
- **What they already know:** Basic Linux shell navigation and running commands as covered in Parts 1–2 of the series
- **What they don't know:** How to audit, remediate, tailor, and enforce security compliance using OpenSCAP, the SCAP Security Guide, `autotailor`, and Image Builder

## Prerequisites

- Completion of Parts 1 and 2 of the RH1 Linux security series (or equivalent familiarity with the RHEL command line)
- Comfort running commands in a Linux terminal
- These prerequisites are trust-based — the lab does not automatically validate prior series completion.

## Learning Objectives

1. Analyze a system's security posture by running an OpenSCAP audit against the CIS Level 1 - Server profile and interpreting the HTML compliance report.
2. Secure a live RHEL system by executing automated OpenSCAP remediation and verifying that target controls change from Fail to Pass.
3. Analyze the differences between CIS Level 1 and CIS Level 2 profiles and identify the rule adjustments required for alternate frameworks such as PCI-DSS and DISA STIG.
4. Configure a custom tailoring profile with `autotailor` to override specific rules without editing vendor source content.
5. Build a pre-hardened RHEL image with Red Hat Image Builder by embedding OpenSCAP directives into a blueprint.

## Content Type

Lab (hands-on), delivered as a Zero-Touch guided Showroom experience.

## Products & Technologies

- Red Hat Enterprise Linux
- OpenSCAP (audit and remediation engine)
- SCAP Security Guide (CIS, PCI-DSS, and DISA STIG policy content)
- `autotailor` (custom tailoring of SCAP profiles)
- Red Hat Image Builder (osbuild-composer — pre-hardened image builds)

## Module Map

| Module | Title | Duration |
|--------|-------|----------|
| 1 | Baseline Assessment (Box 1) | 7 min |
| 2 | Live System Remediation & Verification (Box 1) | 6 min |
| 3 | Advanced Security Standards & Scenarios (Box 2) | 8 min |
| 4 | Policy Customization & Exception Handling (Box 2) | 7 min |
| 5 | Proactive Compliance with Image Builder (Box 2) | 8 min |
| — | **Total hands-on** | **36 min** |
| — | Intro / orientation | ~3 min |
| — | **Total lab** | **~39 min** |

## Difficulty Level

Beginner

## Environment

**Learner view:** When the lab starts, two Red Hat Enterprise Linux systems are pre-deployed and reachable from the guided Showroom terminal — **Box 1** (the initial audit-and-remediation host) and **Box 2** (the advanced-standards, tailoring, and image-building host). OpenSCAP and the SCAP Security Guide content are available for installation, and Box 2 has the tooling needed for `autotailor` and Image Builder workflows. Participants interact entirely through the command line and read generated HTML compliance reports.

**Automation needed:** Yes.

Automation must provision the two RHEL VMs, ensure package repositories for OpenSCAP, the SCAP Security Guide, `autotailor`, and osbuild-composer are reachable, and place the systems in the expected starting state (Box 1 unhardened for the baseline scan; Box 2 ready for Level 2 audits and image builds).

## Infrastructure Requirements

- **Platform:** RHEL VMs (not OpenShift)
- **Cloud provider:** CNV
- **Topology:** Per-student (each learner gets their own dedicated environment)
- **Sizing (per student):**
  - **Box 1** — audit & remediation host: RHEL 10, 2 vCPU, 4 GB RAM, 30 GB disk
  - **Box 2** — advanced standards + Image Builder host: RHEL 10, 4 vCPU, 8 GB RAM, 60 GB disk (extra CPU/disk for osbuild-composer image builds)
- **Operating system:** Red Hat Enterprise Linux 10 (both boxes)
- **Automation approach:** Ansible
- **AI/MaaS:** None
- **External services:**
  - `cdn.redhat.com` — RHEL 10 package content (openscap, scap-security-guide, autotailor, osbuild-composer)
  - `subscription.rhsm.redhat.com` — subscription / entitlement
- **AAP version:** N/A (AAP not used)
- **Non-GA products:** None (all products are GA)

## Assessment Strategy (Optional)

Each module concludes with a verifiable result:

- **Module 1:** An initial OpenSCAP scan completes and produces an HTML report showing the baseline CIS Level 1 score.
- **Module 2:** A follow-up scan confirms target controls have moved from Fail to Pass, raising the compliance score.
- **Module 3:** A CIS Level 2 scan on Box 2 completes and the learner identifies the added/changed controls versus Level 1.
- **Module 4:** A scan run with the custom `autotailor` tailoring profile reflects the disabled rule(s).
- **Module 5:** A pre-hardened QCOW2 image is successfully built from a blueprint containing OpenSCAP directives.

As a Zero-Touch guided lab, per-module solve/validate checks confirm these outcomes.

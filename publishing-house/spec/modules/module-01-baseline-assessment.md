# Module 1: Baseline Assessment (Box 1)

### Brief Overview

This opening module establishes the compliance starting point for the lab. On Box 1, an unhardened Red Hat Enterprise Linux system, participants install OpenSCAP and the SCAP Security Guide, then run their first audit against the CIS Level 1 - Server profile. They open the generated HTML compliance report, read the overall score, and learn to interpret pass/fail results so they understand exactly where the system stands before any remediation. This baseline is the reference point that later modules measure improvement against.

### Audience and Time

- **Personas:** Linux system administrators and security-focused operators, at a beginner level within the guided RH1 series.
- **Prerequisites for this module:** Completion of Parts 1 and 2 of the RH1 Linux security series (or equivalent RHEL command-line familiarity); comfort running commands in a Linux terminal. Prerequisites are trust-based and not automatically validated.
- **Estimated duration:** 7 min

### Learning Objectives

- Install OpenSCAP and the SCAP Security Guide content on Box 1.
- Run an OpenSCAP audit against the CIS Level 1 - Server profile.
- Interpret the generated HTML compliance report to read the baseline score and identify failing controls.

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Prepare Box 1: install OpenSCAP and SCAP Security Guide | 2 min |
| 2 | Run the CIS Level 1 - Server baseline scan | 3 min |
| 3 | Open and interpret the HTML compliance report | 2 min |

### Detailed Steps

1. On the guided Showroom terminal, connect to Box 1 (the unhardened baseline host).
2. Install the OpenSCAP scanner and the SCAP Security Guide content package that supplies the CIS policy.
3. Confirm the SCAP Security Guide data stream file for RHEL is present and locate the CIS Level 1 - Server profile identifier within it.
4. Run an OpenSCAP audit against the CIS Level 1 - Server profile, directing the tool to produce both machine-readable results and an HTML report.
5. Wait for the scan to complete and note where the HTML report file was written.
6. Open the HTML compliance report and read the overall compliance score for the baseline system.
7. Observe the breakdown of passing versus failing rules and review a few representative failed controls, including their severity and remediation descriptions.
8. Record the baseline score so it can be compared against the post-remediation scan in Module 2.

### Key Takeaways

- OpenSCAP paired with the SCAP Security Guide provides a repeatable way to measure a system against an industry benchmark such as CIS Level 1 - Server.
- The HTML compliance report translates raw scan results into a readable score and per-rule pass/fail detail.
- Establishing a baseline score is the essential first step before any remediation, because it defines what "improvement" will be measured against.

### Infrastructure Notes

- Box 1 must start in an unhardened state so the baseline scan produces meaningful failures.
- Package repositories for OpenSCAP and the SCAP Security Guide must be reachable from Box 1.
- Module 1 assessment outcome: an initial OpenSCAP scan completes and produces an HTML report showing the baseline CIS Level 1 score.

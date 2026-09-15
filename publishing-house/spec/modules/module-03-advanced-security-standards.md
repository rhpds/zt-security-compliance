# Module 3: Advanced Security Standards & Scenarios (Box 2)

### Brief Overview

The lab now moves to Box 2, a system prepared for advanced standards work. Participants run an OpenSCAP audit against the CIS Level 2 - Server profile and compare its results to the CIS Level 1 baseline they worked with on Box 1. They learn how Level 2 tightens the posture with additional and stricter controls, and they explore how other frameworks such as PCI-DSS and DISA STIG differ, identifying the rule adjustments each requires. This module builds the judgment needed to choose the right standard for a given environment.

### Audience and Time

- **Personas:** Linux system administrators and security-focused operators, at a beginner level within the guided RH1 series.
- **Prerequisites for this module:** Completion of Modules 1 and 2 (familiarity with running OpenSCAP audits and reading HTML reports against the CIS Level 1 - Server profile); access to Box 2.
- **Estimated duration:** 8 min

### Learning Objectives

- Run an OpenSCAP audit against the CIS Level 2 - Server profile on Box 2.
- Analyze the differences between the CIS Level 1 and CIS Level 2 profiles and identify the added or changed controls.
- Identify the rule adjustments required for alternate frameworks such as PCI-DSS and DISA STIG.

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Prepare Box 2 and locate the CIS Level 2 profile | 2 min |
| 2 | Run the CIS Level 2 - Server audit | 3 min |
| 3 | Compare Level 1 vs Level 2 controls | 2 min |
| 4 | Survey PCI-DSS and DISA STIG differences | 1 min |

### Detailed Steps

1. Connect to Box 2 from the guided Showroom terminal and confirm OpenSCAP and the SCAP Security Guide content are available.
2. Locate the CIS Level 2 - Server profile identifier within the SCAP Security Guide data stream.
3. Run an OpenSCAP audit against the CIS Level 2 - Server profile and generate an HTML report.
4. Open the report and review the Level 2 results, noting the overall score and the set of controls evaluated.
5. Compare the Level 2 control set against the CIS Level 1 - Server profile used earlier, identifying which controls are new or stricter under Level 2.
6. Discuss the operational trade-offs of Level 2's tighter posture versus Level 1.
7. Examine how the PCI-DSS and DISA STIG profiles in the SCAP Security Guide differ, and identify representative rule adjustments each framework requires relative to CIS.
8. Note that selecting a framework is a deliberate decision driven by regulatory and organizational requirements.

### Key Takeaways

- The SCAP Security Guide ships multiple profiles, and CIS Level 2 enforces a stricter posture than CIS Level 1.
- Comparing profiles reveals exactly which additional or changed controls a higher assurance level introduces.
- Alternate frameworks such as PCI-DSS and DISA STIG map to different rule sets, so the choice of standard depends on the environment's compliance obligations.

### Infrastructure Notes

- Box 2 must be ready for Level 2 audits, with OpenSCAP and the SCAP Security Guide content (including PCI-DSS and DISA STIG profiles) available.
- Module 3 assessment outcome: a CIS Level 2 scan on Box 2 completes and the learner identifies the added or changed controls versus Level 1.

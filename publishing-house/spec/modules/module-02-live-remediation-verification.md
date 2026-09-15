# Module 2: Live System Remediation & Verification (Box 1)

### Brief Overview

Having measured the baseline in Module 1, participants now fix the failing controls on the same Box 1 system. They use OpenSCAP's automated remediation to bring the live RHEL host into alignment with the CIS Level 1 - Server profile, then re-run the audit to prove the change worked. This module closes the loop on the audit-remediate-verify cycle: target controls move from Fail to Pass and the overall compliance score rises measurably.

### Audience and Time

- **Personas:** Linux system administrators and security-focused operators, at a beginner level within the guided RH1 series.
- **Prerequisites for this module:** Completion of Module 1 (a baseline CIS Level 1 - Server scan and HTML report on Box 1); comfort running commands in a Linux terminal.
- **Estimated duration:** 6 min

### Learning Objectives

- Execute automated OpenSCAP remediation against the CIS Level 1 - Server profile on the live Box 1 system.
- Verify remediation by re-running the audit and confirming target controls change from Fail to Pass.
- Compare the pre- and post-remediation compliance scores to quantify the improvement.

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Apply automated OpenSCAP remediation on Box 1 | 3 min |
| 2 | Re-run the CIS Level 1 - Server audit | 2 min |
| 3 | Verify Fail-to-Pass transitions and score change | 1 min |

### Detailed Steps

1. On Box 1, review the failing controls identified by the Module 1 baseline scan.
2. Run OpenSCAP in remediation mode against the CIS Level 1 - Server profile so it applies the fixes to the live system.
3. Observe the remediation output as OpenSCAP works through the failed rules and applies corrective actions.
4. Re-run the OpenSCAP audit against the same CIS Level 1 - Server profile, again generating an HTML report.
5. Open the new HTML report and confirm that previously failing target controls now show Pass.
6. Compare the new overall compliance score against the baseline score recorded in Module 1 and confirm it has risen.
7. Note any controls that remain failing and discuss why some rules may require manual intervention rather than automated remediation.

### Key Takeaways

- OpenSCAP can automatically remediate many failing controls on a live system, not just report on them.
- Re-scanning after remediation is essential to verify that controls actually moved from Fail to Pass.
- The audit-remediate-verify cycle produces a measurable increase in the compliance score and demonstrates the value of automated hardening.

### Infrastructure Notes

- Box 1 must carry over its unhardened baseline state from Module 1 so remediation has failing controls to correct.
- Module 2 assessment outcome: a follow-up scan confirms target controls have moved from Fail to Pass, raising the compliance score.

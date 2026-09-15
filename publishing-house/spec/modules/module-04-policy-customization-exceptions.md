# Module 4: Policy Customization & Exception Handling (Box 2)

### Brief Overview

Real-world compliance rarely means accepting a vendor profile unchanged. In this module, participants use `autotailor` on Box 2 to create a custom tailoring profile that overrides specific rules without editing the vendor source content. They then run an OpenSCAP scan using the tailoring profile and confirm the report reflects the disabled rule(s). This teaches a maintainable way to handle justified exceptions while keeping the original SCAP Security Guide content intact and upgradeable.

### Audience and Time

- **Personas:** Linux system administrators and security-focused operators, at a beginner level within the guided RH1 series.
- **Prerequisites for this module:** Completion of Module 3 (running CIS profile audits on Box 2 and interpreting results); `autotailor` tooling available on Box 2.
- **Estimated duration:** 7 min

### Learning Objectives

- Configure a custom tailoring profile with `autotailor` that overrides specific rules.
- Run an OpenSCAP audit using the custom tailoring profile without modifying vendor source content.
- Verify that the scan report reflects the disabled or adjusted rule(s).

### Lab Structure

| Section | Title | Duration |
|---------|-------|----------|
| 1 | Identify rules to tailor and gather their IDs | 2 min |
| 2 | Create a tailoring profile with autotailor | 3 min |
| 3 | Scan with the tailoring profile and verify | 2 min |

### Detailed Steps

1. On Box 2, review a recent CIS profile scan and identify one or more specific rules that need to be overridden or disabled for a justified exception.
2. Note the rule identifiers of the controls to be tailored.
3. Use `autotailor` to generate a custom tailoring profile that overrides those rules, basing it on the existing CIS profile without editing the vendor data stream.
4. Confirm that `autotailor` produced a separate tailoring file and that the original SCAP Security Guide content is unchanged.
5. Run an OpenSCAP audit that applies the tailoring profile alongside the base CIS profile, generating an HTML report.
6. Open the report and confirm the tailored rule(s) are now disabled or adjusted as intended and no longer counted as failures.
7. Discuss how keeping tailoring separate from vendor content makes exceptions auditable and preserves the ability to update the source policy.

### Key Takeaways

- `autotailor` lets you override or disable specific rules through a separate tailoring profile rather than editing vendor content.
- Keeping tailoring separate preserves the integrity and upgradeability of the SCAP Security Guide source policy.
- A tailored scan report clearly reflects the exceptions, keeping justified deviations transparent and auditable.

### Infrastructure Notes

- Box 2 must have `autotailor` and the SCAP Security Guide content available.
- Module 4 assessment outcome: a scan run with the custom `autotailor` tailoring profile reflects the disabled rule(s).

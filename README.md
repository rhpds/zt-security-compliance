# zt-security-compliance

This lab introduces you to automated Linux security compliance through practical, real-world scenario management. Working across two Linux machines, students learn how enterprise organizations measure security health, apply automated fixes, manage policy exceptions, and prevent security drift on fresh deployments.

The lab begins on Box 1 with an initial security audit using OpenSCAP to evaluate an out-of-the-box system and interpret the resulting compliance report. Students then execute automated remediation commands to lock down the system to CIS Level 1 (essential security) and run a follow-up scan to verify that all non-compliant settings pass.

To explore more advanced security models, the lab transitions to Box 2 to run a CIS Level 2 audit, illustrating the difference between standard operational hardening and maximum-security lockdown. Students then practice managing real-world operational exceptions by using autotailor to create custom rule overrides without altering vendor source files. Finally, the lab covers proactive defense by using Red Hat Image Builder to bake compliance profiles directly into OS blueprints, ensuring newly created virtual machines are secure from day one.

**Owner:** jscar-hawk

---

## What was set up

1. Repository created
2. `catalog-info.yaml` added to repository
3. Registered in Developer Hub catalog
4. Orchestrator workflow started — your AI-guided content pipeline is running!

## What happens next

Claude will walk you through the entire content lifecycle — from intake and spec creation, through Jira tracking and reviews, all the way to a published lab on RHDP. Just follow the prompts!

## Getting started

### DevSpaces (recommended)

1. Open in DevSpaces: `https://devspaces.apps.ocpv-infra02.wdc07.infra.demo.redhat.com#https://github.com/rhpds/zt-security-compliance`
2. Use Claude via the **extension** or the **CLI**:
   - **Extension:** Click the **Claude** icon in the sidebar, click **New Session**. If the Claude icon is not visible, open **Extensions** (`Ctrl/Cmd+Shift+X`), find **Claude Code for VS Code** under the DevSpaces section, click it, then click **Enable (Workspace)**.
   - **CLI:** Open a terminal and run `claude`
3. Run `/rhdp-publishing-house` — and you're off!

### Local machine

1. Install the skills:
   ```
   git clone -b prod https://github.com/rhpds/rhdp-publishing-house-skills.git ~/.claude/skills/publishing-house
   ```
2. Clone the repo:
   ```
   git clone https://github.com/rhpds/zt-security-compliance
   ```
3. `cd zt-security-compliance`
4. Start Claude CLI: `claude`
5. Run `/rhdp-publishing-house` — and you're off!

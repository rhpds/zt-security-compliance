# Lab QA

Run from the lab repository in a runner that can reach the provisioned
bastion. The playbooks prefer the runner's injected `bastion_host`,
`bastion_port`, `bastion_user`, and `bastion_password`, then fall back to
`BASTION_*` environment settings (`ANSIBLE_USER` and `ANSIBLE_PASSWORD`
are also supported). If the runner supplies only its `host1` placeholder
for the host, QA uses the lab's in-namespace `rhel:22` SSH service.
Provide credentials via the runner environment, not in Git or CLI arguments.
For a manual run, ensure the bastion's SSH host key is trusted.

```sh
ansible-playbook -i localhost, qa-automation/healthcheck.yml
ansible-playbook -i localhost, qa-automation/e2e.yml
```

Run E2E on a **fresh, disposable QA deployment** with these playbooks and
the same lab content/provisioning revision. Do not run concurrently on the
same deployment or use an active learner instance.

E2E applies actual CIS Level 1 remediation to the bastion and **does not roll
it back**. Discard the deployment afterwards. Module 2 is a documentation-only
walkthrough; E2E does not query advisories or apply updates. On `node1` the playbook verifies both CIS scans, the tailoring
exception, and successful submission of the `qcow2` compose (not full image
completion, which the lab does not require).

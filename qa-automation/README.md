# Lab QA

Run from the lab repository in a runner that can reach the provisioned
bastion. The playbooks build their own inventory from `BASTION_HOST`,
`BASTION_PORT`, `BASTION_USER`, and `BASTION_PASSWORD` (the runner's
`ANSIBLE_USER` / `ANSIBLE_PASSWORD` are supported as fallbacks).
Provide credentials via the runner environment, not in Git or CLI arguments.
For a manual run, ensure the bastion's SSH host key is trusted.

```sh
ansible-playbook -i localhost, qa-automation/healthcheck.yml
ansible-playbook -i localhost, qa-automation/e2e.yml -e qa_disposable_lab=true
```

Run E2E on a **fresh, disposable QA deployment** with these playbooks and
the same lab content/provisioning revision. Do not run concurrently on the
same deployment or use an active learner instance.

E2E applies actual CIS Level 1 remediation to the bastion and **does not roll
it back**. Discard the deployment afterwards. Module 2 only inspects Satellite
advisories. On `node1` the playbook verifies both CIS scans, the tailoring
exception, and successful submission of the `qcow2` compose (not full image
completion, which the lab does not require).

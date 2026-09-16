# DevOps & SRE Engineering Workspace

## Tech & Cloud Stack
- Terraform / OpenTofu / Pulumi
- Kubernetes (k8s), Helm, Docker
- AWS / GCP / Azure Cloud
- Prometheus / Grafana / Datadog

## Safe Infrastructure Practices
- **Plan First**: Never apply changes without inspecting the diff (`terraform plan`, `kubectl diff`).
- **Least Privilege**: Configure IAM roles with minimal necessary permissions.
- **Rollback Preparedness**: Every infrastructure change proposal must state the rollback strategy.

## Harness Commands & Agents
- Spawn `@devops-sre` for incident troubleshooting with the FIRE framework.
- Use `/diagnose` to step through root-cause analysis.
- Use `/sandbox-status` to verify execution isolation.

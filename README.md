# OCI Always Free ARM Auto Retry Deployment

This repo tries to deploy a VM.Standard.A1.Flex ARM instance in Oracle Cloud Infrastructure using Terraform and GitHub Actions.

## Features

- Always Free eligible
- Automatically retries deployment every 30 minutes
- Cycles through Availability Domains (AD-1, AD-2, AD-3)

## Setup Instructions

1. Fork or clone this repo.
2. Go to your GitHub repo -> Settings -> Secrets and variables -> Actions -> New repository secret.
3. Add the following secrets:

- `TENANCY_OCID`
- `USER_OCID`
- `FINGERPRINT`
- `REGION` (e.g., `us-ashburn-1`)
- `COMP_OCID` (your root compartment OCID)
- `PRIVATE_KEY` (paste entire contents of your private API key)

4. Commit and push. GitHub will run Terraform every 30 minutes.

---
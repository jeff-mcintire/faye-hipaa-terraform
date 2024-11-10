## Prerequisite

### Step 1: Configure and Login in AWS CLI
#### a. Configure aws cli profile
Run following command to configure aws cli profile used for this terraform code
```
aws configure sso --profile hipaa-terraform
```
Set the following values to the fields appear in the following order
```
SSO session name (Recommended): don't write anything leave it empty and enter
SSO start URL [None]: https://d-92676903c0.awsapps.com/start#/
SSO region [None]: us-west-2
Select account 254379295007
CLI default client Region [None]: us-west-2
CLI default output format [None]: json
```
#### b. Login
Run following command it will open sso in browser automatically and then you need to select Allow
```
aws sso login --profile hipaa-terraform
```

---
## Terraform commmands
``` hcl
terraform init

terraform plan -var-file variables/global-variables.tfvars

terraform apply -var-file variables/global-variables.tfvars

#To destroy the ccommand to be used will be

terraform destroy -var-file variables/global-variables.tfvars
```
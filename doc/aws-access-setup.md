
## Configure AWS CLI with AWS SSO (Single Sign-On) 



## Configure AWS CLI with IAM user
Configure access to aws from your PC

- create aws user inside aws 
  - `IAM Service -> Users -> Add users -> 'Access key - Programmatic access' -> Users group - admin`
- copy user name `[IAM user's Access key]` and access token `[IAM user's secret key]`
- run in wsl terminal `aws configure`

  - Enter the following details accordingly:
    - AWS Access Key ID `[IAM user's Access key]`
    - AWS Secret Access Key `[IAM user's secret key]`
    - Default region name `[aws region e.g. eu-north-1]`
    - Default output format `[JSON format is fine]`

Check configuration `aws iam get-user`
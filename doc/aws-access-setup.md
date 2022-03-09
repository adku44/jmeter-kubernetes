
## Configure AWS CLI with AWS SSO (Single Sign-On) 

Ensure SSO access to AWS.

Setup default AWS profile. In wsl terminal type with your user profile name `export AWS_PROFILE=[...]`. By default profile name is `accountID_RoleName` i.e. "[7219372198261_AdministratorAccess]"

- Open AWS SSO page to login
- Find credentials 
  - `AWS account -> AWS account 'number' -> 'Command line or programmatic access'`

- Use 'Option 1' `Set AWS environment variables` from tab 'macOS and Linux'
- Copy credentials to WSL terminal.
- Configure aws (only do this point once when first time login). Type `aws configure sso`
  - Enter the following details accordingly:
```
      sso_start_url = [ your sso login page]
      sso_region = eu-west-2
      sso_account_id = [ your account id form sso login page]
      sso_role_name = [ your role ]
      region = eu-west-2
      output = json
```
- Login to your account `aws sso login`
- Check token expiration `aws sts get-caller-identity`

If token has expired login again:
  - Refresh login page to AWS SSO
  - Find new credentials: `AWS account -> AWS account 'number' -> 'Command line or programmatic access'`
  - Copy new credentials to WSL terminal
  - Login again with new credentials `aws sso login`

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
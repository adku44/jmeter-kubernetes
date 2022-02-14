
## Configure AWS CLI with AWS SSO (Single Sign-On) 

- Ensure SSO access to AWS
- Find credentials 
  - `AWS account -> AWS account 'number' -> 'Command line or programmatic access'`
- Use 'Option 2' from tab 'macOS and Linux'
- Copy credentials to `~/.aws/credentials` file in WSL terminal. Here `nano` editor can be used to save credentials.
- Setup default AWS profile. In wsl terminal type with your user profile name `export AWS_PROFILE=[...]`. By default profile name is `accountID_RoleName` i.e. "[729372198261_AdministratorAccess]"
- Login to your account `aws sso login`
- Check token expiration `aws sts get-caller-identity`
- If token has expired login again:
  - Find new credentials: `AWS account -> AWS account 'number' -> 'Command line or programmatic access'`
  - Copy new credentials to `~/.aws/credentials`
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
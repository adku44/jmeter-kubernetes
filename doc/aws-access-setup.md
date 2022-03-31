
## Configure AWS CLI with AWS SSO (Single Sign-On) 

### Prerequisites
Ensure SSO access to AWS.

### Initial profile setup
Setup default AWS profile. In wsl terminal set your user profile name by exporting `AWS_PROFILE` environmental variable. By default profile name consist of two elements: `accountID` and `RoleName` e.g "[7819370159861_AdministratorAccess]" and can be found on SSO login page. The command should look like, e.g.:
```
export AWS_PROFILE=019396424224_AdministratorAccess
```

### Configure SSO
Configure connection to aws (only once when first time login).
```
aws configure sso
```
Enter the following details accordingly:
```
      sso_start_url = [ ... your sso login page] e.g. https://xx.aws.com/start ]
      sso_region = eu-west-2
      sso_account_id = [ ... your account id form sso login page e.g. 019396424224 ]
      sso_role_name = [ ... your role e.g. AdministratorAccess ]
      region = eu-west-2
      output = json
```

### Copy token
Set up valid token for connection to AWS and login:
- Open AWS SSO page to login
- Find credentials 
  - `AWS account -> AWS account 'number' -> 'Command line or programmatic access'`

- Use 'Option 1' `Set AWS environment variables` from tab 'macOS and Linux'
- Copy credentials to WSL terminal.

### Login to AWS
Login to your account
```
aws sso login
```

### Verify connection to AWS
Check token expiration 
```
aws sts get-caller-identity
```

### Token refresion
Life time of token is quite short. When you get a message on your console: `error: You must be logged in to the server (Unauthorized)`
it means that you token has expired.

If token has expired login again: 
  - Refresh login page to AWS SSO
  - Find new credentials: `AWS account -> AWS account 'number' -> 'Command line or programmatic access'`
  - Copy new credentials to WSL terminal
  - Login again with new credentials `aws sso login`


## Configure AWS CLI with IAM user (not applicable)
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
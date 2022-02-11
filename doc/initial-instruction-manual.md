
This manual covers information about necessary tools to setup basic kubernetes environment.
Kubernetes environment is setup in AWS (Amazon Web Services) by EKSCTL tool.

## install WSL:
Windows Subsystem for Linux
Please follow the instructions for installation in microsoft manual
```
https://docs.microsoft.com/en-us/windows/wsl/install
```
e.g. Ubuntu 20.4 LTS

## Run WSL terminal
In Windows
```
press Windows logo key + R
type wsl
```
When WSL terminal is opened type `cd`
to change to home directory


## Install AWS CLI
AWS-CLI installer for Linux x86
```
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

## Install EKSCTL
```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
```

## Install KUBECTL
```
sudo curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && mv ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
kubectl version --short --client
```

## Install aws-iam-authenticator
```
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && mv ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
aws-iam-authenticator version
```





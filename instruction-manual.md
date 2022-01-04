
# Prerequisities
## install WSL:
Windows Subsystem for Linux
'''
https://docs.microsoft.com/en-us/windows/wsl/install
'''
e.g. Ubuntu 20.4 LTS

## Run WSL terminal

## Install AWS CLI
configure access to aws:
- create aws user inside aws 
- copy user name and access key
- run in wsl terminal:   aws configure

## Install EKSCTL
'''
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
'''

## Install KUBECTL:

## Install aws-iam-authenticator


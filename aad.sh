#! /bin/bash

export AWS_ACCESS_KEY_ID="ADDSSSD"
export AWS_SECRET_ACCESS_KEY="sdijosdj32nazwa"
export AWS_REGION="eu-west-2"
echo $AWS_ACCESS_KEY_ID
echo $AWS_SECRET_ACCESS_KEY
echo $AWS_REGION
eksctl create cluster --region=eu-west-2 --nodes=2 --instance-types=t3.large --name=LTaas-ww



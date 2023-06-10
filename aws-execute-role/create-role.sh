#!/bin/bash

## input aws profile
echo input aws profile
read profile

includesProfile=false
## check aws profile
for p in `grep profile ~/.aws/config| awk '{print $2}' | sed 's/]$//'`
do
  if [ "$profile" == "$p" ]
  then 
    includesProfile=true
  fi
done

if [ "$includesProfile" == "false" ]
then
  echo $includesProfile
  echo "invalid profile"
  exit 1
fi

ROLE_NAME=TerraformValidationRole
POLICY_NAME=ALBFullAccessPolicy
ALB_POLICY_FILE=alb-full-access-policy.json

# Check if role exists
role_exists=$(aws iam get-role --role-name $ROLE_NAME --profile $profile 2>/dev/null)

if [ -z "$role_exists" ]; then
    # If the role does not exist, create it
    aws iam create-role --role-name $ROLE_NAME --assume-role-policy-document file://trust-policy.json --profile $profile
fi

# Check if policy exists
policy_arn=$(aws iam list-policies --profile $profile --query "Policies[?PolicyName=='$POLICY_NAME'].Arn" --output text)

if [ -z "$policy_arn" ]; then
    # If the policy does not exist, create it
    policy_arn=$(aws iam create-policy --policy-name $POLICY_NAME --policy-document file://$ALB_POLICY_FILE --profile $profile --query "Policy.Arn" --output text)
fi

# List all the attached policies
attached_policies=$(aws iam list-attached-role-policies --role-name $ROLE_NAME --profile $profile --query "AttachedPolicies[*].PolicyArn" --output text)

# For each policy, check if it's attached. If not, attach it.
for policy in "arn:aws:iam::aws:policy/AmazonVPCFullAccess" "arn:aws:iam::aws:policy/AmazonS3FullAccess" "arn:aws:iam::aws:policy/AmazonRoute53FullAccess" "arn:aws:iam::aws:policy/AmazonEC2FullAccess" "arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess" "arn:aws:iam::aws:policy/AmazonSSMFullAccess" "$policy_arn"
do
    if [[ ! $attached_policies == *$policy* ]]; then
        aws iam attach-role-policy --role-name $ROLE_NAME --policy-arn $policy --profile $profile
    fi
done

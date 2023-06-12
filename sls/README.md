```yaml
functions:
  hello-go:
    handler: bin/hello
    disableLogs: true
```

% npx serverless deploy --aws-profile terraform

Deploying sls to stage dev (ap-northeast-1)

✖ Stack sls-dev failed to deploy (61s)
Environment: darwin, node 18.13.0, framework 3.32.2, plugin 6.2.3, SDK 4.3.2
Credentials: Local, "terraform" profile
Docs:        docs.serverless.com
Support:     forum.serverless.com
Bugs:        github.com/serverless/serverless/issues

Error:
CREATE_FAILED: IamRoleLambdaExecution (AWS::IAM::Role)
Policy statement must contain resources. (Service: AmazonIdentityManagement; Status Code: 400; Error Code: MalformedPolicyDocument; Request ID: 9f764f80-d043-4e1d-ada1-7ed033d82c0b; Proxy: null)


```yaml
functions:
  hello-go:
    handler: bin/hello
    disableLogs: false
```

% npx serverless deploy --aws-profile terraform

Deploying sls to stage dev (ap-northeast-1)

✔ Service deployed to stack sls-dev (55s)

functions:
  hello-go: sls-dev-hello-go (2.9 MB)

Need a faster logging experience than CloudWatch? Try our Dev Mode in Console: run "serverless dev"s


```yaml
functions:
  hello-go:
    handler: bin/hello
    disableLogs: true
```

% npx serverless deploy --aws-profile terraform

Deploying sls to stage dev (ap-northeast-1)

✖ Stack sls-dev failed to deploy (14s)
Environment: darwin, node 18.13.0, framework 3.32.2, plugin 6.2.3, SDK 4.3.2
Credentials: Local, "terraform" profile
Docs:        docs.serverless.com
Support:     forum.serverless.com
Bugs:        github.com/serverless/serverless/issues

Error:
UPDATE_FAILED: IamRoleLambdaExecution (AWS::IAM::Role)
Policy statement must contain resources. (Service: AmazonIdentityManagement; Status Code: 400; Error Code: MalformedPolicyDocument; Request ID: 77846c9f-03ef-418d-bc9d-a4b389ca6237; Proxy: null)


```yaml
functions:
  hello-go:
    handler: bin/hello
    disableLogs: false
    events:
      - iot:
          sql: "SELECT * FROM 'test'"
```

% npx serverless deploy --aws-profile terraform

Deploying sls to stage dev (ap-northeast-1)

✔ Service deployed to stack sls-dev (40s)

functions:
  hello-go: sls-dev-hello-go (2.9 MB)


一度removeして再度デプロイしてみる
```yaml
functions:
  hello-go:
    handler: bin/hello
    disableLogs: false
    events:
      - iot:
          sql: "SELECT * FROM 'test'"
```

% npx serverless deploy --aws-profile terraform

Deploying sls to stage dev (ap-northeast-1)

✖ Stack sls-dev failed to deploy (56s)
Environment: darwin, node 18.13.0, framework 3.32.2, plugin 6.2.3, SDK 4.3.2
Credentials: Local, "terraform" profile
Docs:        docs.serverless.com
Support:     forum.serverless.com
Bugs:        github.com/serverless/serverless/issues

Error:
CREATE_FAILED: IamRoleLambdaExecution (AWS::IAM::Role)
Policy statement must contain resources. (Service: AmazonIdentityManagement; Status Code: 400; Error Code: MalformedPolicyDocument; Request ID: 9cd579c4-a98b-4f05-aea3-a465202e39d1; Proxy: null)



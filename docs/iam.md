# IAM – Roles and Policies

## IAM Role: cloudlingo-translate-role

This role is created and managed via Terraform. It is assumed by AWS Lambda and has the following permissions:

### Trust Policy

Allows the following principal to assume the role:

```json
{
  "Service": "lambda.amazonaws.com"
}
```

### Permissions Policy

The attached IAM policy allows the Lambda function to:

* **Read input files** from `cloudlingo-request-bucket` using `s3:GetObject`
* **Write output files** to `cloudlingo-response-bucket` using `s3:PutObject`
* **Call AWS Translate** using `translate:TranslateText`
* **Write logs** to CloudWatch using:

  * `logs:CreateLogGroup`
  * `logs:CreateLogStream`
  * `logs:PutLogEvents`

All IAM logic is defined in Terraform in the `main.tf` file.

# Troubleshooting

##  Lambda Not Triggering

* Ensure S3 PUT event is properly configured as a trigger
* Re-add the trigger if needed and make sure it is **enabled**

##  No Logs in CloudWatch

* Likely the trigger did not fire
* Try uploading a file with a new name (e.g. `test2.json`)
* Check IAM permissions for the Lambda role

## Access Denied

* IAM policy must include:

  * `translate:TranslateText`
  * `s3:GetObject` and `s3:PutObject`
  * Logging permissions for CloudWatch

##  Unexpected Output or Errors

* Ensure JSON format is valid
* Make sure both `source_language` and `target_language` are supported by AWS Translate

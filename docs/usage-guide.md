# Usage Guide

## Upload a File

```bash
aws s3 cp sample_input.json s3://cloudlingo-request-bucket/test1.json
```

## Confirm Lambda Triggered

Check CloudWatch logs for new log streams under:

```
/aws/lambda/cloudlingo-translator
```

## Download Result

```bash
aws s3 cp s3://cloudlingo-response-bucket/translated_test1.json .
```

## Manual Testing (Optional)

```bash
python scripts/translate.py
```

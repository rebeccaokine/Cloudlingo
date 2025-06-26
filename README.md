# Cloudlingo – A Serverless Translation Pipeline on AWS

Cloudlingo is a lightweight, fully serverless application designed to translate text files using AWS Translate. It automates the process of detecting a new file upload, translating the content, and storing the result, all built within AWS Free Tier limits.

The infrastructure is provisioned using Terraform, and the backend logic runs in a Lambda function triggered by S3 events. The goal was to create a simple, scalable solution that demonstrates practical use of Infrastructure-as-Code and serverless design on AWS.


## Features

- Upload a JSON file containing text and language metadata
- Automatic language translation using AWS Translate
- Translated output is saved in a separate S3 bucket
- Built to run with no server management required


## Project Structure

```
Cloudlingo/
├── docs/
│ ├── architecture.md
│ ├── iam.md
│ ├── troubleshooting.md
│ ├── usage-guide.md
│ └── workflow.md
├── scripts/ # Python scripts
│ ├── lambda_handler.py
│ └── translate.py # Manual test script
├── terraform/
│ ├── main.tf
│ ├── outputs.tf
│ └── variables.tf
├── test_files/
│ └── sample_input.json
└── README.md

```

## How it Works

1. The user uploads a JSON file to the request bucket.
2. S3 automatically triggers the Lambda function.
3. Lambda reads the file, performs translation using AWS Translate, and writes the result to the response bucket.
4. The output file is named using a `translated_` prefix.


## Example Input

```json
{
  "text": "Hello, world!",
  "source_language": "en",
  "target_language": "es"
}
```


## Example Output

```json
{
  "original_text": "Hello, world!",
  "translated_text": "Hola, mundo!",
  "source_language": "en",
  "target_language": "es"
}
```


## Getting Started

To test the pipeline:

1. Upload the file:
aws s3 cp test_files/sample_input.json s3://cloudlingo-request-bucket/sample_input.json

2. After a few seconds, check the response bucket:
aws s3 ls s3://cloudlingo-response-bucket/

3. Download and inspect the result:
aws s3 cp s3://cloudlingo-response-bucket/translated_sample_input.json .

## Documentation

Detailed information is available in the docs/ directory:

- architecture.md: How the system is structured

- iam.md: Roles and permissions

- workflow.md: Step-by-step processing

- usage-guide.md: How to use and test the app

- troubleshooting.md: Common issues and solutions

## Technologies Used

- AWS S3

- AWS Lambda

- AWS Translate

- AWS IAM

- Python (Boto3)

- Terraform

## Author
Rebecca N.A. Okine
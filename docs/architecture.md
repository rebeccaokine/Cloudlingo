# Architecture Overview

Cloudlingo is a serverless, event-driven pipeline for translating text files using AWS.

## Components

* **Amazon S3**

  * `cloudlingo-request-bucket`: Accepts uploaded JSON input
  * `cloudlingo-response-bucket`: Stores translated JSON output

* **AWS Lambda**

  * Executes translation logic when files are uploaded to S3

* **AWS Translate**

  * Performs the actual language translation

* **IAM Role**

  * Lambda uses a least-privilege role provisioned by Terraform

## Design Goals

* Fully automated (no manual translation)
* Event-driven and cost-efficient
* Built entirely within AWS Free Tier limits

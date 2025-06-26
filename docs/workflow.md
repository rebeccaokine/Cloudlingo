# Workflow

## Input File Format

```json
{
  "text": "Hello, world!",
  "source_language": "en",
  "target_language": "es"
}
```

## Steps

1. User uploads `.json` file to `cloudlingo-request-bucket`
2. S3 triggers the Lambda function
3. Lambda reads, translates, and writes output to `cloudlingo-response-bucket`
4. Output file is named: `translated_<original_filename>.json`

## Output Example

```json
{
  "original_text": "Hello, world!",
  "translated_text": "Hola, mundo!",
  "source_language": "en",
  "target_language": "es"
}
```

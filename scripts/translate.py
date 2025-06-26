import boto3
import json

REQUEST_BUCKET = "cloudlingo-request-bucket"
RESPONSE_BUCKET = "cloudlingo-response-bucket"
REGION = "us-east-1"

s3 = boto3.client("s3", region_name=REGION)
translate = boto3.client("translate", region_name=REGION)

def translate_file(file_key):
    # Step 1: Read input JSON from S3
    response = s3.get_object(Bucket=REQUEST_BUCKET, Key=file_key)
    file_content = response["Body"].read().decode("utf-8")
    data = json.loads(file_content)

    text = data["text"]
    source_lang = data["source_language"]
    target_lang = data["target_language"]

    result = translate.translate_text(
        Text=text,
        SourceLanguageCode=source_lang,
        TargetLanguageCode=target_lang
    )

    translated_text = result["TranslatedText"]

    output_data = {
        "original_text": text,
        "translated_text": translated_text,
        "source_language": source_lang,
        "target_language": target_lang
    }

    output_key = f"translated_{file_key}"

    s3.put_object(
        Bucket=RESPONSE_BUCKET,
        Key=output_key,
        Body=json.dumps(output_data),
        ContentType="application/json"
    )

    print(f"✅ Translated file uploaded as: {output_key}")


if __name__ == "__main__":
    translate_file("sample_input.json")

import boto3
import json

s3 = boto3.client("s3")
translate = boto3.client("translate")

RESPONSE_BUCKET = "cloudlingo-response-bucket"

def lambda_handler(event, context):
    try:
        bucket = event['Records'][0]['s3']['bucket']['name']
        key = event['Records'][0]['s3']['object']['key']

        obj = s3.get_object(Bucket=bucket, Key=key)
        file_content = obj['Body'].read().decode('utf-8')
        data = json.loads(file_content)

        text = data['text']
        source_lang = data['source_language']
        target_lang = data['target_language']

        result = translate.translate_text(
            Text=text,
            SourceLanguageCode=source_lang,
            TargetLanguageCode=target_lang
        )
        translated_text = result['TranslatedText']

        output_data = {
            "original_text": text,
            "translated_text": translated_text,
            "source_language": source_lang,
            "target_language": target_lang
        }

        output_key = f"translated_{key}"
        s3.put_object(
            Bucket=RESPONSE_BUCKET,
            Key=output_key,
            Body=json.dumps(output_data),
            ContentType='application/json'
        )

        return {"statusCode": 200, "body": f"Translated file saved as {output_key}"}

    except Exception as e:
        print("❌ Error:", e)
        return {"statusCode": 500, "body": str(e)}

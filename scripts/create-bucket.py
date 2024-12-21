import boto3

s3_target = boto3.resource(
    "s3",
    endpoint_url="http://minio.registry.svc.cluster.local:9000",
    aws_access_key_id="admin",
    aws_secret_access_key="ABN9ck07J3",
    aws_session_token=None,
    config=boto3.session.Config(signature_version="s3v4"),
    verify=False,
)

s3_target.create_bucket(Bucket="mlflow")

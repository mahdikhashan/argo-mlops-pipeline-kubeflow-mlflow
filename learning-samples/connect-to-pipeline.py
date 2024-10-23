from kfp.client import Client

client = Client(host='http://localhost:3000')
run = client.create_run_from_pipeline_package(
    'pipeline.yaml',
    arguments={
        'recipient': 'World',
    },
)

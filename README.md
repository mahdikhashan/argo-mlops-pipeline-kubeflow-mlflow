MLOps Pipeline for Distributed Model Training with Kubeflow
---

#### Description

TODO


### Structure, language, and illustrations 

TODO

### Summary of research 

TODO

### Tutorial (step-by-step instructions & reproducibility)

link to API and UI docker images: https://hub.docker.com/u/mahdikhashan

### Summary of lessons-learned

In pursuit of learning to implement infrastructure for Machine Learning in production, 
I faced multiple challenges. I added multiple GitHub issues for each during different phases of project development.

Additionally, I learned to use variety of tools, concepts and solution practices for implementing this project which I had never tried before like Bash, Makefiles
, ArgoCD (GitOps), Kubernetes, Helm, Kubeflow, MLFlow and Streamlit. Foreach I have a few learning examples that comes in following paragraphs:

##### Challenges while learning about Kubeflow: TODO

TODO




helm upgrade --install mlflow community-charts/mlflow \
--version 0.9.1 \
--set backendStore.databaseMigration=true \
--set backendStore.postgres.enabled=true \
--set backendStore.postgres.host=database-postgresql.registry.svc.cluster.local \
--set backendStore.postgres.port=5432 \
--set backendStore.postgres.database=postgres \
--set backendStore.postgres.user=postgres \
--set backendStore.postgres.password=jSQ8Gr6c1F \
--set artifactRoot.s3.enabled=true \
--set artifactRoot.s3.bucket=mlflow \
--set artifactRoot.s3.awsAccessKeyId=admin \
--set artifactRoot.s3.awsSecretAccessKey=4ujL68KZev \
--set extraEnvVars.MLFLOW_S3_ENDPOINT_URL=minio.registry.svc.cluster.local:9000 \
--set extraEnvVars.AWS_ACCESS_KEY_ID=admin \
--set extraEnvVars.AWS_SECRET_ACCESS_KEY=ABN9ck07J3 \
--set serviceMonitor.enabled=true
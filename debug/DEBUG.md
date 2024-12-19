DEBUG
---

enable shell

```bash
nix-shell debug.nix
```

remove minio 

```bash
kubectl delete -f minio/minio-dev.yaml
```

add bitnami repo

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Database
---


install postgres

```bash
helm version
helm install my-postgresql bitnami/postgresql --version 16.3.2
```

PostgreSQL can be accessed via port 5432 on the following DNS names from within your cluster:

    my-postgresql.default.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

```bash
export POSTGRES_PASSWORD=$(kubectl get secret --namespace default my-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)
```

```bash
echo $POSTGRES_PASSWORD
```

To connect to your database run the following command:
```bash
kubectl run my-postgresql-client --rm --tty -i --restart='Never' --namespace default --image docker.io/bitnami/postgresql:17.2.0-debian-12-r3 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host my-postgresql -U postgres -d postgres -p 5432
```

then run:

    psql -U postgres -d postgres -c "SELECT version();"

    > NOTE: If you access the container using bash, make sure that you execute "/opt/bitnami/scripts/postgresql/entrypoint.sh /bin/bash" in order to avoid the error "psql: local user with ID 1001} does not exist"

To connect to your database from outside the cluster execute the following commands:

```bash
kubectl port-forward --namespace default svc/my-postgresql 5432:5432 & PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432
```

WARNING: The configured password will be ignored on new installation in case when previous PostgreSQL release was deleted through the helm command. In that case, old PVC will have an old password, and setting it through helm won't take effect. Deleting persistent volumes (PVs) will solve the issue.

WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
- primary.resources
- readReplicas.resources
  +info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/


ObjectStorage
---

install minio

```bash
helm version
helm repo update
helm install my-minio bitnami/minio --version 14.10.2
```

MinIO&reg; can be accessed via port  on the following DNS name from within your cluster:

    my-minio.default.svc.cluster.local

To get your credentials run:

```bash
export MINIO_USER=$(kubectl get secret --namespace default my-minio -o jsonpath="{.data.root-user}" | base64 -d)
export MINIO_PASSWORD=$(kubectl get secret --namespace default my-minio -o jsonpath="{.data.root-password}" | base64 -d)
```

```bash
echo $MINIO_USER # admin
echo $MINIO_PASSWORD # 4ujL68KZev
```

To connect to your MinIO&reg; server using a client:

- Run a MinIO&reg; Client pod and append the desired command (e.g. 'admin info'):

```bash
kubectl run --namespace default my-minio-client \
  --rm --tty -i --restart='Never' \
  --env MINIO_SERVER_ROOT_USER=minioadmin \
  --env MINIO_SERVER_ROOT_PASSWORD=minioadmin \
  --env MINIO_SERVER_HOST=my-minio \
  --image docker.io/bitnami/minio-client:2024.11.21-debian-12-r1 -- /usr/bin/mc
```

To access the MinIO&reg; web UI:

- Get the MinIO&reg; URL:

  echo "MinIO&reg; web URL: http://127.0.0.1:9001/minio"

```bash
kubectl port-forward --request-timeout='0' --namespace default svc/my-minio 9001:9001
```

### this works

```bash
while true; do kubectl --namespace default port-forward svc/my-minio 9001; done
```

WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
- resources
  +info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/


MLFlow
---

```bash
helm repo add community-charts https://community-charts.github.io/helm-charts
```

```bash
helm upgrade --install mlflow community-charts/mlflow \
  --version 0.9.1 \
  --set backendStore.databaseMigration=true \
  --set backendStore.postgres.enabled=true \
  --set backendStore.postgres.host=my-postgresql.default.svc.cluster.local \
  --set backendStore.postgres.port=5432 \
  --set backendStore.postgres.database=postgres \
  --set backendStore.postgres.user=postgres \
  --set backendStore.postgres.password=PX4wf8Ubs3 \
  --set artifactRoot.s3.enabled=true \
  --set artifactRoot.s3.bucket=mlflow \
  --set artifactRoot.s3.awsAccessKeyId=admin \
  --set artifactRoot.s3.awsSecretAccessKey=4ujL68KZev \
  --set extraEnvVars.MLFLOW_S3_ENDPOINT_URL=my-minio.default.svc.cluster.local:9000 \
  --set extraEnvVars.AWS_ACCESS_KEY_ID=admin \
  --set extraEnvVars.AWS_SECRET_ACCESS_KEY=4ujL68KZev \
  --set serviceMonitor.enabled=true
```

Get the application URL by running these commands:

```bash
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=mlflow,app.kubernetes.io/instance=mlflow" -o jsonpath="{.items[0].metadata.name}")
export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
```

```bash
echo "Visit http://127.0.0.1:8080 to use your application"
```   

```bash
kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```

it worked!

this value was supposed to be set in the model.py

os.environ["AWS_ACCESS_KEY_ID"] = "admin"
os.environ["AWS_SECRET_ACCESS_KEY"] = "4ujL68KZev"
os.environ["MLFLOW_S3_ENDPOINT_URL"] = "http://localhost:9000"

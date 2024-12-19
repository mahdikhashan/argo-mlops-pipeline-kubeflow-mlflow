API Service
---

#### build

```bash
docker build -t api-service .
```

#### run

```bash
docker run -d -p 8000:8000 -e MLFLOW_TRACKING_URI=http://0.0.0.0:8090/ api-service:latest 
```

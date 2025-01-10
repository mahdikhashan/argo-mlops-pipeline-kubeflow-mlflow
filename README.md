MLOps Pipeline for Distributed Model Training with Kubeflow
---

#### Description

An MLOps pipeline leveraging the cloud-native Kubeflow project for model training and registration with MLflow. GitOps practices are implemented using ArgoCD to deploy a custom Kubeflow Helm chart to a Kubernetes cluster on DigitalOcean.

#### Argo Apps

| Application | Git Repository | Version |
| - | - | - |
| Kubeflow | https://github.com/mahdikhashan/kubeflow-helm-chart | 0.0.1 |
| MLFlow | https://github.com/mahdikhashan/mlflow-helm-chart | 0.0.1 |
| Grafana | https://grafana.github.io/helm-charts | 8.6.4 |
| Prometheus | https://prometheus-community.github.io/helm-charts | 26.0.0 |

---

#### Documentation

- [Setup](./docs/SETUP.md)
- [Research Summary](./docs/RESEARCH_SUMMARY.md)
- [Learning](./docs/LEARNINGS.md)
- [Architecture](./docs/ARCH.md)
- [Challenges](./docs/CHALLENGES.md)
- Components
  - [Kubeflow](./docs/KUEBFLOW.md)
  - [ArgoCD](./docs/ARGO.md)
  - [MLFlow](./apps/registry/mlflow/README.md)

--- 

[LICENCE](./LICENSE)

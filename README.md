MLOps Pipeline for Distributed Model Training with Kubeflow
---

#### Description

An MLOps Pipeline using cloud native project Kubeflow to train and register models in MLFlow. Using GitOps to deploy Custom Kubeflow Helm Chart on Kubernetes cluster on any cloud, here the implementation has targeted Digital Ocean.

#### Argo Apps

| Application | Git Repository | Version |
| - | - | - |
| Kubeflow | https://github.com/mahdikhashan/kubeflow-helm-chart/tree/main | 0.0.1 |
| MLFlow | https://github.com/mahdikhashan/mlflow-helm-chart | 0.0.1 |

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

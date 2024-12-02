## MLOps Pipeline for Distributed Model Training with Kubeflow

We propose to develop an MLOps pipeline focused on distributed model training
using the Kubeflow ecosystem. The project will explore continuous training (CT)
of machine learning models on a CPU-based environment, emphasizing the orchestration
of training within a cluster. We aim to automate the pipeline with GitHub Actions and
possibly package the solution with Helm charts. The deployment may occur on either a
cloud provider or local infrastructure, depending on further investigation.

Key components include:

- Distributed training orchestration via Kubeflow.
- Microservices for monitoring datasets and managing model training, with potential use of a load balancer or gateway.
- A basic user interface for live demonstration using the Streamlit package.
- Model hyperparameter monitoring, potentially with MLflow.
- Optional components: data processing pipeline, model registry, resource definition files (Terraform), and GitOps (ArgoCD).

We are still deciding on the model, dataset, and other specifics.
Your early feedback will help guide further development.

![Initial Illustration of the proposed architecture](https://github.com/mahdikhashan/jku-cloud-computing/blob/main/docs/drawings/YoloV5_mlops_arch_draft_v1.png?raw=true)

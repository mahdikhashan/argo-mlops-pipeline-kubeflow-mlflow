## MLOps Pipeline for Distributed Model Training with Kubeflow

We propose to develop an MLOps pipeline focused on distributed model training
using the Kubeflow ecosystem. The project will explore continuous training (CT)
of machine learning models on a CPU-based environment, emphasizing the orchestration
of training within a cluster. We aim to automate the pipeline with GitHub Actions and
possibly package the solution with Helm charts. The deployment may occur on either a
cloud provider or local infrastructure, depending on further investigation.

### Key components include

- Distributed training orchestration via Kubeflow.
- Microservices for monitoring datasets and managing model training, with potential use of a load balancer or gateway.
- A basic user interface for live demonstration using the Streamlit package.
- Model hyperparameter monitoring, potentially with MLflow.
- Model serving with Flask REST API
- Optional components: data processing pipeline, model registry, and GitOps (ArgoCD).

### Milestones

1. Set up a Kubernetes Cluster on Local (Mac with Silicon CPU)
2. Run a couple of Kubeflow components on Local
3. Decide on the Computation budget (Resources, Number of nodes, Training time)
4. Decide on ML model and methods
5. Implement a couple of models
6. Decide on the user story (demo flow)
7. Learn to use GitOps and implement an example solution
8. Decide on Cloud Provider
9. Set up Kubeflow on a cluster
10. Decide on kubeflow component usage
11. Implement serving and training components of architecture

### Responsibilities 

After a few back and forth trails to build a team, the first team failed to work together due to different dynamics of members.
Then I (Mahdi Khashan) decided to continue working on this idea and by consultation with Dr.Braeuer, I got the chance to start earlier with the project and 
onboard one more member on the way. Still the member onboarding process is to due and I was not able to find anybody. 


### Demo flow

The Demo flow would be serving of the trained model (MNIST with CNN Architecture with different hyperparameters), registering it in the MLFlow model registery on an object storage. Then serving it through a REST API and consuming the API with 
Streamlit UI by being able to select different registered model and end-user (Machine Learning Engineers or Data Scientist) drawing there test illustration on a canvas component.

![Initial Illustration of the proposed architecture](https://github.com/mahdikhashan/jku-cloud-computing/blob/main/docs/drawings/YoloV5_mlops_arch_draft_v1.png?raw=true)

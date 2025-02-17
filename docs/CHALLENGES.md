Challenges
---

#### MLFlow Deployment

##### first challenge: Namespace was not set in the used chart

while [this](https://artifacthub.io/packages/helm/community-charts/mlflow) Helm chart seems to be a major release by the community, 
I was not able to deploy it by Argo. the Argo was complaining that the spec has error, after going through it, i noticed that the namespace should explicitly be defined in the spec and in used the Helm chart - they are not setting it. 

##### solution

basiclly, i have added namespace field with a default value and ability to set from values be passing it. it will be installed in the default namespace.

between commiting on the project itself and forking it - i decided to go with the latter and have my own patch of the package. its not the 
correct way to handle it since after they release an update, i will miss it (i need to merge it to my own fork) - but since i am not sure what i'm doing wrong here with Argo - it was a fast go to solution.

my fork is here: https://github.com/mahdikhashan/mlflow-helm-chart

##### second challenge: connect to database and object storage

my first decision was to host the database, object storage required for mlflow - by myself. i pretty late understood its not a right approach.
i can leave it to the cloud - for anything like management and so on. 

the challenge was that i could not open the minio-ui by port-forwarding - there is an existing issue with kubernetes for it. finally, i found a solution (https://github.com/mahdikhashan/jku-cloud-computing/blob/local-debugging/debug/DEBUG.md). but eventually, when i connected both of them - in testing pipeline i could not register the model into it (which later i noticed it was another issue, not related to minio). 

##### solution

so, i wasted a lot of time here, which i could go for the cloud provided solution for object storage and database. only for the idea of having a single command deployment solution. now i need to create db and object storage in cloud beforehand.

related issue: https://github.com/mahdikhashan/argocd-mlops-pipeline-kubeflow-mlflow/issues/28


#### ArgoCD

1. Syncing Kubeflow: https://github.com/mahdikhashan/argocd-mlops-pipeline-kubeflow-mlflow/issues/29
2. Automatic syncing fails without namespace being created first: https://github.com/mahdikhashan/argocd-mlops-pipeline-kubeflow-mlflow/issues/15

#### Kubeflow Deployment

1. Creating Notebook issue: https://github.com/mahdikhashan/argocd-mlops-pipeline-kubeflow-mlflow/issues/22

#### Kubernetes

1. Removing orphan component: https://github.com/mahdikhashan/argocd-mlops-pipeline-kubeflow-mlflow/issues/16
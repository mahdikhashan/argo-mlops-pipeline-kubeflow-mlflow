# Cloud Computing Course Project

### MLOps Pipeline for Distributed Model Training with Kubeflow



## Structure, language, and illustrations 

TODO

## Summary of research 

TODO

## Tutorial (step-by-step instructions & reproducibility)

TODO

## Summary of lessons-learned

In pursuit of learning to implement infrastructure for Machine Learning in production, 
I faced multiple challenges. I added multiple GitHub issues for each during different phases of project development.

Additionally, I learned to use variety of tools, concepts and solution practices for implementing this project which I had never tried before like Bash, Makefiles
, ArgoCD (GitOps), Kubernetes, Helm, Kubeflow, MLFlow and Streamlit. Foreach I have a few learning examples that comes in following paragraphs:

#### Challenges while learning about Kubeflow: TODO

TODO

### References: 

Papers:
1. Hidden Technical Debt in Machine Learning Systems by multiple authors from Google (https://proceedings.neurips.cc/paper_files/paper/2015/file/86df7dcfd896fcaf2674f757a2463eba-Paper.pdf)

Articles and Docs: 
1. MLOps: Continuous delivery and automation pipelines in machine learning (https://cloud.google.com/architecture/mlops-continuous-delivery-and-automation-pipelines-in-machine-learning)
2. https://neptune.ai/blog/mlops-architecture-guide
3. https://medium.com/@d.ryabokon/ci-cd-ct-with-mlflow-and-github-actions-2a6ba5c767dd
4. https://freedium.cfd/https://santiagof.medium.com/effortless-models-deployment-with-mlflow-2b1b443ff157
5. https://medium.com/@andrewpmcmahon629/some-architecture-design-principles-for-mlops-llmops-a505628a903e
6. https://www.interline.io/blog/scaling-openstreetmap-data-workflows/
7. https://freedium.cfd/https://towardsdatascience.com/how-to-design-an-mlops-architecture-in-aws-67ee9843a430
8. https://abhinav332.medium.com/orchestrate-machine-learning-model-with-kubeflow-11945e7801b5
9. https://www.mlflow.org/docs/latest/models.html#how-to-log-models-with-signatures
10. https://learn.microsoft.com/en-us/azure/machine-learning/concept-distributed-training?view=azureml-api-2
11. https://pytorch.org/docs/stable/nn.html#torch.nn.parallel.DistributedDataParallel
12. https://www.kubeflow.org/docs/components/pipelines/legacy-v1/introduction/
13. https://developers.google.com/machine-learning/guides/rules-of-ml/#training-serving_skew
14. https://github.com/GokuMohandas/Made-With-ML
15. https://ml-ops.org/
16. https://www.kubeflow.org/docs/components/training/reference/distributed-training/
17. https://anjuls.medium.com/machine-learning-orchestration-on-kubernetes-using-kubeflow-2069767e20ca
18. https://fmind.medium.com/how-to-install-kubeflow-on-apple-silicon-3565db8773f3
19. https://medium.com/@vinayakshanawad/build-an-ml-pipeline-part-2-model-registration-and-serving-with-mlflow-and-kserve-a2158337e077

Books:
1. Distributed Machine Learning Patterns by Yuan Tang (https://www.goodreads.com/book/show/59113140-distributed-machine-learning-patterns)
2. Machine Learning Yearning by Andrew Ng (https://www.goodreads.com/book/show/30741739-machine-learning-yearning)
3. KubernetesL Up & Running by Hightower, Burns and Beda - First Edition (https://www.goodreads.com/book/show/26759355-kubernetes)

Videos:
1. Production-Ready AI Platform on Kubernetes - Yuan Tang, Red Hat (https://www.youtube.com/watch?v=_RthQ01bwU8)
2. https://www.youtube.com/watch?v=MeU5_k9ssrs

Code Samples:
1. https://github.com/kubeflow/examples/tree/master/pytorch_mnist

Architecture Samples: 
1. https://drive.google.com/file/d/1TLzFTQylZMMaD9yC2HfGho_MjhZvpWLQ/view
2. https://medium.com/revolut/building-a-state-of-the-art-card-fraud-detection-system-in-9-months-96463d7f652d
3. https://neptune.ai/blog/how-these-8-companies-implement-mlops
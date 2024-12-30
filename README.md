MLOps Pipeline for Distributed Model Training with Kubeflow
---

#### Description

TODO

### Tutorial (step-by-step instructions & reproducibility)

#### 1. Setup local environment

To ease the project development and reproducibility, I have used a nix shell to separate this project from my local setup.

on Mac, use the following command to install nix. then enable shell:
```bash
sh <(curl -L https://nixos.org/nix/install)
```

for other OSs follow [this](https://nixos.org/download/) link.

to enable shell:
```bash
nix-shell
```

this shell will install Python 3.12, yamlfmt, pre-commit, ruff and a few others. afterward, create a virtual environment and 
attach it to the current shell. finally I'm logging the yamlfmt and pre-commit version - then setup pre-commit.

- pre-commits are **ruff** (for python linting) and **yamlfmt** to lint and format yamls (k8s resources files).

#### 2. Setup cloud

I'm using Digital Ocean for K8s, Database and Object Storage. To ease the creation and removal of cluster and other apps, 
i'm leveraging a [Makefile](./Makefile). There I have multiple steps and commands, which can be run together or alone.

then to setup the cluster, make sure you have `doctcl`. for Mac, use the following command to install it:

```bash
brew install doctl
```

for other OSs follow [this](https://docs.digitalocean.com/reference/doctl/how-to/install/) link.

to have a working connection, we need to have an access token. which can be generated from [this](https://docs.digitalocean.com/reference/api/create-personal-access-token/) link.
then store the generated token in a raw file named `dotoken` in the root path of the project, the Makefile will use it (the file should be `dotoken` without any extension).

next, run `init-doctl` from the Makefile like:

```bash
make init-doctl
```

it will authenticate the CLI tool with the server and afterward we can use the services.

next, to create the cluster run `do-create-cluster`. it will create a cluster with two nodes with following config:

1. Node 1 = 4 vCPU (intel) - 8gb - 160 GB Disk
2. Node 1 = 4 vCPU (intel) - 8gb - 160 GB Disk

to run the command with Make:

```bash
make do-create-cluster
```

this command will take a while and finally (if no interruption causes failure) we have a kubernetes cluster (with command plane on one node) and 
two worker node with the above config.

then to store the cluster config on local (kubectl), use the `do-cluster-config` command, with make:

```bash
make do-cluster-config
```

finally to make sure worker nodes are attached to the cluster, run `do-cluster-get-nodes`:

```bash
make do-cluster-get-nodes
```

right now we should have a working cluster with 2 nodes. to further check the running pods, use `k9s` to observe already running
pods and other resources. 

#### 3. Install ArgoCD

since i'm using ArgoCD, we have another command in the Makefile to install it, patch it to request a LoadBalancer and then 
patch ArgoCD secret, custom repositories and secrets. 

```bash
make install-argo
```

this command return the public ip address of the ArgoCD and then we can use the credentials from [this](./docs/ARGO.md) file to login.

#### 4. Install Apps

to setup the apps (kubeflow, mlflow, monitoring and inference) on ArgoCD, use the following command:

```bash
make install-base-argo-app
```

it will install the base app of ArgoCD, and this app will install the rest (manual syncing is required - refer to [this](./docs/ARGO.md) doc). 

5. Appends Configs
6. Run Inference

##### Links 

- link to API and UI docker images: https://hub.docker.com/u/mahdikhashan

---

#### Documentation

- [Research Summary](./docs/RESEARCH_SUMMARY.md)
- [Learning](./docs/LEARNINGS.md)
- [Architecture](./docs/ARCH.md)
- [Challenges](./docs/CHALLENGES.md)
- Components
  - [Kubeflow](./docs/KUEBFLOW.md)
  - [ArgoCD](./docs/ARGO.md)
  - [MLFlow](./apps/registry/mlflow/README.md)

CURRENT_DIR:=$(shell pwd)

DO_ACCESS_TOKEN:=$(shell cat dotoken)

DO_CLUSTER_NAME:=kubeflow
DO_CLUSTER_SIZE:=s-2vcpu-4gb
DO_CLUSTER_NODE_COUNT:=1

all: debug

debug:
	echo CURRENT_DIR is ${CURRENT_DIR}
	echo Using shell: $$SHELL
	echo Digital Ocean Token ${DO_ACCESS_TOKEN}

init-doctl:
	doctl auth init --access-token ${DO_ACCESS_TOKEN}

.PHONY: debug
do-create-cluster: debug
	doctl kubernetes cluster create kubeflow --count=DO_CLUSTER_NODE_COUNT --size=DO_CLUSTER_SIZE

do-cluster-config: debug
	doctl kubernetes cluster kubeconfig save 5a233a77-d9a1-44e6-a91f-2d3f0cce75a3

do-cluster-get-nodes: debug
	kubectl --kubeconfig=/Users/mahdikhashan/.kube/config get nodes

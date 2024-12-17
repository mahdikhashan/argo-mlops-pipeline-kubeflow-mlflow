{{ if .Values.kubeflowPipelines.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kubeflow-pipelines
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: "200"
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
{{ .Values.kubeflowPipelines.spec | toYaml | indent 2 }}
{{- end -}}

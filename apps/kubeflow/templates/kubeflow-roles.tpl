{{ if .Values.kubeflowRoles.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kubeflow-roles
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: "10"
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
{{ .Values.kubeflowRoles.spec | toYaml | indent 2 }}
{{- end -}}

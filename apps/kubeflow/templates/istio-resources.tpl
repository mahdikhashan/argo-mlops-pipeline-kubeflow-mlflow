{{ if .Values.istioResources.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: istio-resources
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: "10"
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
{{ .Values.istioResources.spec | toYaml | indent 2 }}
{{- end -}}

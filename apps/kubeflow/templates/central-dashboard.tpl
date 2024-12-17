{{ if .Values.centralDashboard.enabled -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: central-dashboard
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
  annotations:
    argocd.argoproj.io/sync-wave: "100"
spec:
{{ .Values.centralDashboard.spec | toYaml | indent 2 }}
{{- end -}}

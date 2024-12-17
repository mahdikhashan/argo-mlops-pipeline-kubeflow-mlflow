{{ if .Values.networkPolicies.enabled -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: network-policies
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: "9"
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
{{ .Values.networkPolicies.spec | toYaml | indent 2 }}
{{- end -}}

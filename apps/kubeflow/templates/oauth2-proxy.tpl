{{ if .Values.oauth2Proxy.enabled -}}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: oauth2-proxy
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: "9"
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
{{ .Values.oauth2Proxy.spec | toYaml | indent 2 }}
{{- end -}}

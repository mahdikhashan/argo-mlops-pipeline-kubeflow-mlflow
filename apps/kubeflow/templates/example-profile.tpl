{{ if .Values.exampleProfile.enabled }}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: example-profile
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-wave: "102"
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
{{ .Values.exampleProfile.spec | toYaml | indent 2 }}
{{- end -}}

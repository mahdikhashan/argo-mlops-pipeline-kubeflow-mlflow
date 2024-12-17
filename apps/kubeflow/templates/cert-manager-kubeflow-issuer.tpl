{{ if .Values.certManagerKubeflowIssuer.enabled -}}
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: kubeflow-self-signing-issuer
  labels:
    app.kubernetes.io/component: cert-manager
    app.kubernetes.io/name: cert-manager
    kustomize.component: cert-manager
  annotations:
    argocd.argoproj.io/sync-wave: "100"
spec:
{{ .Values.certManagerKubeflowIssuer.spec | toYaml | indent 2 }}
{{- end -}}

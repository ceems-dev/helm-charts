{{/* Generate name for admission */}}
{{- define "kube-ceems.admission.fullname" }}
{{- printf "%s-admission" (include "kube-ceems.fullname" .) -}}
{{- end }}

{{/* Generate basic labels for webhook */}}
{{- define "kube-ceems.admission.webhook.labels" }}
{{- include "kube-ceems.labels" . }}
app: {{ template "kube-ceems.name" . }}-admission-webhook
app.kubernetes.io/name: {{ template "kube-ceems.name" . }}-admission-webhook
app.kubernetes.io/component: ceems-webhook
{{- end }}

{{/* Generate basic labels for controller */}}
{{- define "kube-ceems.admission.controller.labels" }}
{{- include "kube-ceems.labels" . }}
app: {{ template "kube-ceems.name" . }}-admission-controller
app.kubernetes.io/name: {{ template "kube-ceems.name" . }}-admission-controller
app.kubernetes.io/component: ceems-webhook
{{- end }}

{{/* Create the name of kube-ceems service account to use */}}
{{- define "kube-ceems.admission.controller.serviceAccountName" -}}
{{- if .Values.ceemsAPIServer.serviceAccount.create -}}
    {{ default (printf "%s-admission-controller" (include "kube-ceems.fullname" .)) .Values.ceemsAPIServer.admissionWebhooks.deployment.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.ceemsAPIServer.admissionWebhooks.deployment.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/* Generate webhook DNS names */}}
{{- define "kube-ceems.admission.webhook.dnsNames" }}
{{- $fullname := include "kube-ceems.fullname" . }}
{{- $namespace := include "kube-ceems.namespace" . }}
{{- $fullname }}
{{ $fullname }}.{{ $namespace }}.svc
{{ $fullname }}-admission-controller
{{ $fullname }}-admission-controller.{{ $namespace }}.svc
{{- end }}

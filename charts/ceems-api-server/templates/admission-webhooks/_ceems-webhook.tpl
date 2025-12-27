{{/* Generate name for admission */}}
{{- define "ceems-api-server.admission.fullname" }}
{{- printf "%s-admission" (include "ceems-api-server.fullname" .) -}}
{{- end }}

{{/* Generate basic labels for webhook */}}
{{- define "ceems-api-server.admission.webhook.labels" }}
{{- include "ceems-api-server.common-labels" . }}
app: {{ template "ceems-api-server.name" . }}-admission-webhook
app.kubernetes.io/name: {{ template "ceems-api-server.name" . }}-admission-webhook
app.kubernetes.io/component: ceems-webhook
{{- end }}

{{/* Generate basic labels for controller */}}
{{- define "ceems-api-server.admission.controller.labels" }}
{{- include "ceems-api-server.common-labels" . }}
app: {{ template "ceems-api-server.name" . }}-admission-controller
app.kubernetes.io/name: {{ template "ceems-api-server.name" . }}-admission-controller
app.kubernetes.io/component: ceems-webhook
{{- end }}

{{/* Create the name of ceems-api-server service account to use */}}
{{- define "ceems-api-server.admission.controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (printf "%s-admission-controller" (include "ceems-api-server.fullname" .)) .Values.admissionWebhooks.deployment.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.admissionWebhooks.deployment.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/* Generate webhook DNS names */}}
{{- define "ceems-api-server.admission.webhook.dnsNames" }}
{{- $fullname := include "ceems-api-server.fullname" . }}
{{- $namespace := include "ceems-api-server.namespace" . }}
{{- $fullname }}
{{ $fullname }}.{{ $namespace }}.svc
{{ $fullname }}-admission-controller
{{ $fullname }}-admission-controller.{{ $namespace }}.svc
{{- end }}

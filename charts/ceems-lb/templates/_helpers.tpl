{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ceems-lb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ceems-lb.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ceems-lb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ceems-lb.common-labels" -}}
helm.sh/chart: {{ include "ceems-lb.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: {{ template "ceems-lb.name" . }}
app.kubernetes.io/version: "{{ replace "+" "_" .Chart.Version }}"
release: {{ $.Release.Name | quote }}
heritage: {{ $.Release.Service | quote }}
{{- with .Values.commonLabels }}
{{ tpl (toYaml .) $ }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "ceems-lb.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
The image to use
*/}}
{{- define "ceems-lb.image" -}}
{{- if .Values.image.sha }}
{{- fail "image.sha forbidden. Use image.digest instead" }}
{{- else if .Values.image.digest }}
{{- if .Values.global.imageRegistry }}
{{- printf "%s/%s:%s@%s" .Values.global.imageRegistry .Values.image.repository (default (printf "v%s" .Chart.AppVersion) .Values.image.tag) .Values.image.digest }}
{{- else }}
{{- printf "%s/%s:%s@%s" .Values.image.registry .Values.image.repository (default (printf "v%s" .Chart.AppVersion) .Values.image.tag) .Values.image.digest }}
{{- end }}
{{- else }}
{{- if .Values.global.imageRegistry }}
{{- printf "%s/%s:%s" .Values.global.imageRegistry .Values.image.repository (default (printf "v%s" .Chart.AppVersion) .Values.image.tag) }}
{{- else }}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.repository (default (printf "v%s" .Chart.AppVersion) .Values.image.tag) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Formats imagePullSecrets. Input is (dict "Values" .Values "imagePullSecrets" .{specific imagePullSecrets})
*/}}
{{- define "ceems-lb.imagePullSecrets" -}}
{{- range (concat .Values.global.imagePullSecrets .imagePullSecrets) }}
  {{- if eq (typeOf .) "map[string]interface {}" }}
- {{ toYaml . | trim }}
  {{- else }}
- name: {{ . }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
-------------------------------------------------------------------------------
CEEMS LB related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Generate basic labels for ceems-lb
*/}}
{{- define "ceems-lb.labels" }}
{{- include "ceems-lb.common-labels" . }}
app: {{ template "ceems-lb.name" . }}
app.kubernetes.io/name: {{ template "ceems-lb.name" . }}
app.kubernetes.io/component: load-balancer
{{- end }}

{{/* 
Generate selector labels for ceems-lb
*/}}
{{- define "ceems-lb.selectorLabels" -}}
app: {{ template "ceems-lb.name" . }}
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for ceems-lb
*/}}
{{- define "ceems-lb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ceems-lb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create config for ceems lb
*/}}
{{- define "ceems-lb.config" -}}
{{- with  .Values.config }}
ceems_lb:
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- if ne .Values.ceemsAPIServer.persistenceVolumeClaim "" }}
ceems_api_server:
  data:
    path: /var/lib/ceems_api_server
{{- else }}
{{- if not (empty .Values.ceemsAPIServer.web) }}
ceems_api_server:
  web:
{{- with  .Values.ceemsAPIServer.web }}
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Backend server types for ceems lb
*/}}
{{- define "ceems-lb.backend-types" -}}
{{- $backends := list -}}
{{- if (hasKey .Values.config "backends") }}
{{- range $_, $value := .Values.config.backends }}
{{- if (hasKey $value "tsdb") }}
{{- $backends = append $backends "tsdb" -}}
{{- end }}
{{- if (hasKey $value "pyroscope") }}
{{- $backends = append $backends "pyroscope" -}}
{{- end }}
{{- end }}
{{- end }}
{{- $backends = $backends | uniq -}}
{{ $backends | join "-" }}
{{- end }}

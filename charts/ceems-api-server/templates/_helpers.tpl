{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ceems-api-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ceems-api-server.fullname" -}}
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
{{- define "ceems-api-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ceems-api-server.common-labels" -}}
helm.sh/chart: {{ include "ceems-api-server.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: {{ template "ceems-api-server.name" . }}
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
{{- define "ceems-api-server.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
The image to use
*/}}
{{- define "ceems-api-server.image" -}}
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
{{- define "ceems-api-server.imagePullSecrets" -}}
{{- range (concat .Values.global.imagePullSecrets .imagePullSecrets) }}
  {{- if eq (typeOf .) "map[string]interface {}" }}
- {{ toYaml . | trim }}
  {{- else }}
- name: {{ . }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
CEEMS current cluster id
*/}}
{{- define "ceems-api-server.cluster-id" -}}
{{- default (printf "%s-k8s-0" .Release.Name) .Values.clusterID }}
{{- end }}

{{/*
-------------------------------------------------------------------------------
Templates copied from children charts for generating service URLs
-------------------------------------------------------------------------------
*/}}

{{/*
kube-prometheus-stack fullname based on its default value
*/}}
{{- define "ceems-api-server.kube-prometheus-stack.fullname" -}}
{{- printf "%s-kube-prometheus-stack" .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- end -}}

{{/*
Prometheus service URL
*/}}
{{- define "ceems-api-server.prometheus-svc-url" -}}
http://{{ include "ceems-api-server.kube-prometheus-stack.fullname" . }}-prometheus.{{ include "ceems-api-server.namespace" . }}:9090
{{- end }}

{{/*
-------------------------------------------------------------------------------
CEEMS API server related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Generate basic labels for ceems-api-server
*/}}
{{- define "ceems-api-server.labels" }}
{{- include "ceems-api-server.common-labels" . }}
app: {{ template "ceems-api-server.name" . }}
app.kubernetes.io/name: {{ template "ceems-api-server.name" . }}
app.kubernetes.io/component: ceems-api-server
{{- end }}

{{/* 
Generate selector labels for ceems-api-server
*/}}
{{- define "ceems-api-server.selectorLabels" -}}
app: {{ template "ceems-api-server.name" . }}
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for ceems-api-server
*/}}
{{- define "ceems-api-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ceems-api-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Data path for ceems api server
*/}}
{{- define "ceems-api-server.data-path" -}}
{{- $path := default "/var/lib/ceems_api_server" .Values.dataConfig.path -}}
{{- if (isAbs $path) }}
{{- printf "%s" $path }}
{{- else }}
{{- printf "/%s" $path }}
{{- end }}
{{- end }}

{{/*
Create clusters config for ceems api server
*/}}
{{- define "ceems-api-server.clusters-config" -}}
{{- $clusterids := list -}}
{{- $clusterid := (include "ceems-api-server.cluster-id" .) -}}
{{- range $_, $value := .Values.clusters }}
{{- $clusterids = append $clusterids $value.id }}
- {{ tpl (toYaml $value) $  | indent 2 | trim }}
{{- end -}}
{{- if and .Values.monitorCurrentCluster (not (has $clusterid $clusterids)) }}
- id: {{ $clusterid }}
  manager: k8s
  updaters:
    - {{ $clusterid }}-tsdb
{{- end }}
{{- end }}

{{/*
Create updaters config for ceems api server
*/}}
{{- define "ceems-api-server.updaters-config" -}}
{{- $updaterids := list -}}
{{- $updaterid := printf "%s-tsdb" (include "ceems-api-server.cluster-id" .) -}}
{{- range $_, $value := .Values.updaters }}
{{- $updaterids = append $updaterids $value.id }}
- {{ tpl (toYaml $value) $  | indent 2 | trim }}
{{- end -}}
{{- if and .Values.monitorCurrentCluster (not (has $updaterid $updaterids)) }}
- id: {{ $updaterid }}
  updater: tsdb
  web:
    url: {{ include "ceems-api-server.prometheus-svc-url"  . }}
{{- end }}
{{- end }}

{{/*
Create config for ceems api server
*/}}
{{- define "ceems-api-server.config" -}}
{{- if or .Values.dataConfig .Values.adminConfig -}}
ceems_api_server:
{{- if .Values.dataConfig -}}
{{- $config := .Values.dataConfig -}}
{{- $_ := set $config "path" (include "ceems-api-server.data-path" .) -}}
{{- with .Values.dataConfig }}
  data:
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- if .Values.adminConfig -}}
{{- with .Values.adminConfig }}
  admin:
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- end }}
{{- if or .Values.clusters .Values.monitorCurrentCluster }}
clusters:
{{- include "ceems-api-server.clusters-config" . }}
{{- end }}
{{- if or .Values.updaters .Values.monitorCurrentCluster }}
updaters:
{{- include "ceems-api-server.updaters-config" . }}
{{- end }}
{{- end }}

{{/* 
Generate basic labels for admission-controller
*/}}
{{- define "ceems-api-server.admissionController.labels" }}
{{- include "ceems-api-server.common-labels" . }}
app: {{ template "ceems-api-server.name" . }}-admission-controller
app.kubernetes.io/name: {{ template "ceems-api-server.name" . }}-admission-controller
app.kubernetes.io/component: ceems-admission-webhook
{{- end }}

{{/* 
Generate selector labels for admission-controller
*/}}
{{- define "ceems-api-server.admissionController.selectorLabels" -}}
app: {{ template "ceems-api-server.name" . }}-admission-controller
release: {{ $.Release.Name | quote }}
{{- end }}

{{/* 
TLS config for admission-controller app
*/}}
{{- define "ceems-api-server.admissionController.webConfig" -}}
tls_server_config:
  cert_file: tls.crt
  key_file: tls.key
{{- end }}

{{/* 
Generate service URL for admission-controller app
*/}}
{{- define "ceems-api-server.admissionController.svcURL" -}}
{{ template "ceems-api-server.fullname" . }}.{{ include "ceems-api-server.namespace" . }}.svc
{{- end }}

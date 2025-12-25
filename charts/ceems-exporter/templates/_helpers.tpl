{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ceems-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ceems-exporter.fullname" -}}
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
{{- define "ceems-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ceems-exporter.common-labels" -}}
helm.sh/chart: {{ include "ceems-exporter.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: {{ template "ceems-exporter.name" . }}
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
{{- define "ceems-exporter.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
The image to use
*/}}
{{- define "ceems-exporter.image" -}}
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
{{- define "ceems-exporter.imagePullSecrets" -}}
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
CEEMS Exporter related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Generate labels for ceems-exporter
*/}}
{{- define "ceems-exporter.labels" -}}
{{- include "ceems-exporter.common-labels" . }}
app: {{ template "ceems-exporter.name" . }}-exporter
app.kubernetes.io/name: {{ template "ceems-exporter.name" . }}-exporter
app.kubernetes.io/component: ceems-prometheus-exporter
{{- end }}


{{/* 
Generate selector labels for ceems-exporter
*/}}
{{- define "ceems-exporter.selectorLabels" -}}
app: {{ template "ceems-exporter.name" . }}-exporter
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for ceems-exporter
*/}}
{{- define "ceems-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ceems-exporter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the namespace name of the service monitor
*/}}
{{- define "ceems-exporter.monitor-namespace" -}}
{{- if .Values.namespaceOverride }}
{{- .Values.namespaceOverride }}
{{- else }}
{{- if .Values.prometheus.monitor.namespace }}
{{- .Values.prometheus.monitor.namespace }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}
{{- end }}

{{/* Sets default scrape limits for servicemonitor */}}
{{- define "servicemonitor.scrapeLimits" -}}
{{- with .sampleLimit }}
sampleLimit: {{ . }}
{{- end }}
{{- with .targetLimit }}
targetLimit: {{ . }}
{{- end }}
{{- with .labelLimit }}
labelLimit: {{ . }}
{{- end }}
{{- with .labelNameLengthLimit }}
labelNameLengthLimit: {{ . }}
{{- end }}
{{- with .labelValueLengthLimit }}
labelValueLengthLimit: {{ . }}
{{- end }}
{{- end }}

{{/* Sets auth config for servicemonitor */}}
{{- define "servicemonitor.authConfig" -}}
{{- $defaultAuthorization := dict -}}
{{- $defaultTlsConfig := dict -}}
{{- $scheme := .Values.prometheus.monitor.scheme -}}
{{- if .Values.kubeRBACProxy.enabled }}
{{- $defaultAuthorization = dict "type" "Bearer" "credentials" (dict "name" "ceems-exporter-servicemonitor-token" "key" "token") -}}
{{- $defaultTlsConfig = dict "insecureSkipVerify" true -}}
{{- $scheme = "https" -}}
{{- end }}
{{- $tlsConfig := default $defaultTlsConfig .Values.prometheus.monitor.tlsConfig -}}
{{- $authorization := default $defaultAuthorization .Values.prometheus.monitor.authorization -}}
scheme: {{ $scheme }}
{{- with .Values.prometheus.monitor.basicAuth }}
basicAuth:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with $authorization }}
authorization:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with $tlsConfig }}
tlsConfig:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.prometheus.monitor.proxyUrl }}
{{- with .Values.prometheus.monitor.oauth2 }}
oauth2:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the namespace name of the pod monitor
*/}}
{{- define "ceems-exporter.podmonitor-namespace" -}}
{{- if .Values.namespaceOverride }}
{{- .Values.namespaceOverride }}
{{- else }}
{{- if .Values.prometheus.podMonitor.namespace }}
{{- .Values.prometheus.podMonitor.namespace }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}
{{- end }}

{{/* Sets default scrape limits for podmonitor */}}
{{- define "podmonitor.scrapeLimits" -}}
{{- with .sampleLimit }}
sampleLimit: {{ . }}
{{- end }}
{{- with .targetLimit }}
targetLimit: {{ . }}
{{- end }}
{{- with .labelLimit }}
labelLimit: {{ . }}
{{- end }}
{{- with .labelNameLengthLimit }}
labelNameLengthLimit: {{ . }}
{{- end }}
{{- with .labelValueLengthLimit }}
labelValueLengthLimit: {{ . }}
{{- end }}
{{- end }}

{{/* Sets auth config for podmonitor */}}
{{- define "podmonitor.authConfig" -}}
{{- $defaultAuthorization := dict -}}
{{- $defaultTlsConfig := dict -}}
{{- $scheme := .Values.prometheus.podMonitor.scheme -}}
{{- if .Values.kubeRBACProxy.enabled }}
{{- $defaultAuthorization = dict "type" "Bearer" "credentials" (dict "name" "rbacproxytoken" "key" "token") -}}
{{- $defaultTlsConfig = dict "insecureSkipVerify" true -}}
{{- $scheme = "https" -}}
{{- end }}
{{- $tlsConfig := default $defaultTlsConfig .Values.prometheus.podMonitor.tlsConfig -}}
{{- $authorization := default $defaultAuthorization .Values.prometheus.podMonitor.authorization -}}
scheme: {{ $scheme }}
{{- with .Values.prometheus.podMonitor.basicAuth }}
basicAuth:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with $authorization }}
authorization:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with $tlsConfig }}
tlsConfig:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.prometheus.podMonitor.proxyUrl }}
{{- with .Values.prometheus.podMonitor.oauth2 }}
oauth2:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Sets manifest that creates secret when kubeRBACProxy is enabled
*/}}
{{- define "ceems-exporter.service-monitor-secret" -}}
{{- if .Values.kubeRBACProxy.enabled }}
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: ceems-exporter-servicemonitor-token
  annotations:
    kubernetes.io/service-account.name: {{ include "ceems-exporter.serviceAccountName" . }}
{{- end }}
{{- end }}

{{/*
Create redfish config for ceems exporter
*/}}
{{- define "ceems-exporter.redfish-config" -}}
{{- $config := .Values.collectors.redfish.config -}}
{{- if .Values.redfishProxy.enabled -}}
{{- $externalUrl := default (include "ceems-exporter.redfish-proxy.svc-url" .) $config.external_url -}}
{{- $_ := set $config "external_url" $externalUrl -}}
{{- if .Values.redfishProxy.kubeRBACProxy.enabled -}}
{{- $authorization := dict "type" "Bearer" "credentials_file" "/var/run/secrets/kubernetes.io/serviceaccount/token" -}}
{{- $_ := set $config "authorization" $authorization -}}
{{- $tls := dict "insecure_skip_verify" true -}}
{{- $_ := set $config "tls_config" $tls -}}
{{- end -}}
{{- end -}}
{{- with $config }}
redfish_collector: 
{{ tpl (toYaml .) $ | indent 2 }}
{{- end }}
{{- end }}

{{/*
Create profiling config for ceems exporter
*/}}
{{- define "ceems-exporter.profiling-config" -}}
ceems_profiler: 
{{- if (hasKey .Values.eBPFProfiling.config "ebpf") }}
  ebpf:
{{- with  .Values.eBPFProfiling.config.ebpf }}
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- if (hasKey .Values.eBPFProfiling.config "pyroscope") }}
  pyroscope:
{{- with  .Values.eBPFProfiling.config.pyroscope }}
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- else }}
  pyroscope:
    url: http://{{ printf "%s-pyroscope" .Release.Name | trunc 63 | trimSuffix "-" }}.{{ include "ceems-exporter.namespace" . }}:4040
{{- end }}
{{- end }}

{{/*
-------------------------------------------------------------------------------
Redfish Proxy related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Fullname suffixed with -redfish-proxy 
Adding 9 to 26 truncation of ceems-exporter.fullname 
*/}}
{{- define "ceems-exporter.redfish-proxy.fullname" -}}
{{- if .Values.redfishProxy.fullnameOverride -}}
{{- .Values.redfishProxy.fullnameOverride | trunc 35 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-redfish-proxy" (include "ceems-exporter.fullname" .) -}}
{{- end }}
{{- end }}

{{/* 
Generate basic labels for redfish-proxy
*/}}
{{- define "ceems-exporter.redfish-proxy.labels" }}
{{- include "ceems-exporter.common-labels" . }}
app: {{ template "ceems-exporter.name" . }}-redfish-proxy
app.kubernetes.io/name: {{ template "ceems-exporter.name" . }}-redfish-proxy
app.kubernetes.io/component: proxy
{{- end }}

{{/* 
Generate selector labels for redfish-proxy
*/}}
{{- define "ceems-exporter.redfish-proxy.selectorLabels" -}}
app: {{ template "ceems-exporter.name" . }}-redfish-proxy
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for redfish-proxy
*/}}
{{- define "ceems-exporter.redfish-proxy.serviceAccountName" -}}
{{- if .Values.redfishProxy.serviceAccount.create }}
{{- default (include "ceems-exporter.redfish-proxy.fullname" .) .Values.redfishProxy.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.redfishProxy.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Use the redfish-proxy namespace override for multi-namespace deployments in combined charts
*/}}
{{- define "ceems-exporter.redfish-proxy.namespace" -}}
  {{- if index .Values "redfishProxy" "namespaceOverride" -}}
    {{- index .Values "redfishProxy" "namespaceOverride" -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/* 
Service URL of redfish-proxy that is accessible from exporter pods
*/}}
{{- define "ceems-exporter.redfish-proxy.svc-url" -}}
{{- $servicePort := .Values.redfishProxy.service.port -}}
{{- $protocol := "http" -}}
{{- if .Values.redfishProxy.kubeRBACProxy.enabled -}}
{{- $protocol = "https" -}}
{{- end }}
{{- printf "%s://%s.%s.svc:%d" $protocol (include "ceems-exporter.redfish-proxy.fullname" .) (include "ceems-exporter.redfish-proxy.namespace" .) ($servicePort | int) -}}
{{- end }}

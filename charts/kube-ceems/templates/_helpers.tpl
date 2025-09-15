{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kube-ceems.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kube-ceems.fullname" -}}
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
{{- define "kube-ceems.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kube-ceems.labels" -}}
helm.sh/chart: {{ include "kube-ceems.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/part-of: {{ template "kube-ceems.name" . }}
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
{{- define "kube-ceems.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
The image to use
*/}}
{{- define "kube-ceems.image" -}}
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
{{- define "kube-ceems.imagePullSecrets" -}}
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
{{- define "kube-ceems.cluster-id" -}}
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
{{- define "kube-ceems.kube-prometheus-stack.fullname" -}}
{{- printf "%s-kube-prometheus-stack" .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- end -}}

{{/*
Prometheus service URL
*/}}
{{- define "kube-ceems.prometheus-svc-url" -}}
http://{{ include "kube-ceems.kube-prometheus-stack.fullname" . }}-prometheus.{{ include "kube-ceems.namespace" . }}:9090
{{- end }}

{{/*
Pyroscope fullname based on its default value
*/}}
{{- define "kube-ceems.pyroscope.fullname" -}}
{{- printf "%s-pyroscope" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Pyroscope Grafana datasource name
*/}}
{{- define "kube-ceems.pyroscope-ds-name" -}}
kube-ceems-pyroscope
{{- end }}

{{/*
Pyroscope service URL
*/}}
{{- define "kube-ceems.pyroscope-svc-url" -}}
http://{{ include "kube-ceems.pyroscope.fullname" . }}.{{ include "kube-ceems.namespace" . }}:4040
{{- end }}

{{/*
-------------------------------------------------------------------------------
CEEMS Exporter related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Fullname suffixed with -exporter 
Adding 9 to 26 truncation of kube-ceems.fullname 
*/}}
{{- define "kube-ceems.exporter.fullname" -}}
{{- if .Values.ceemsExporter.fullnameOverride -}}
{{- .Values.ceemsExporter.fullnameOverride | trunc 35 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-exporter" (include "kube-ceems.fullname" .) -}}
{{- end }}
{{- end }}

{{/* 
Generate basic labels for ceems-exporter
*/}}
{{- define "kube-ceems.exporter.labels" }}
{{- include "kube-ceems.labels" . }}
app: {{ template "kube-ceems.name" . }}-exporter
app.kubernetes.io/name: {{ template "kube-ceems.name" . }}-exporter
app.kubernetes.io/component: ceems-prometheus-exporter
{{- end }}

{{/* 
Generate selector labels for ceems-exporter
*/}}
{{- define "kube-ceems.exporter.selectorLabels" -}}
app: {{ template "kube-ceems.name" . }}-exporter
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for ceems-exporter
*/}}
{{- define "kube-ceems.exporter.serviceAccountName" -}}
{{- if .Values.ceemsExporter.serviceAccount.create }}
{{- default (include "kube-ceems.exporter.fullname" .) .Values.ceemsExporter.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ceemsExporter.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Use the ceems-exporter namespace override for multi-namespace deployments in combined charts
*/}}
{{- define "kube-ceems.exporter.namespace" -}}
  {{- if index .Values "ceemsExporter" "namespaceOverride" -}}
    {{- index .Values "ceemsExporter" "namespaceOverride" -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create the namespace name of the service monitor
*/}}
{{- define "kube-ceems.exporter.monitor-namespace" -}}
{{- if .Values.ceemsExporter.namespaceOverride }}
{{- .Values.ceemsExporter.namespaceOverride }}
{{- else }}
{{- if .Values.ceemsExporter.prometheus.monitor.namespace }}
{{- .Values.ceemsExporter.prometheus.monitor.namespace }}
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
{{- $scheme := .Values.ceemsExporter.prometheus.monitor.scheme -}}
{{- if .Values.ceemsExporter.kubeRBACProxy.enabled }}
{{- $defaultAuthorization = dict "type" "Bearer" "credentials" (dict "name" "ceems-exporter-servicemonitor-token" "key" "token") -}}
{{- $defaultTlsConfig = dict "insecureSkipVerify" true -}}
{{- $scheme = "https" -}}
{{- end }}
{{- $tlsConfig := default $defaultTlsConfig .Values.ceemsExporter.prometheus.monitor.tlsConfig -}}
{{- $authorization := default $defaultAuthorization .Values.ceemsExporter.prometheus.monitor.authorization -}}
scheme: {{ $scheme }}
{{- with .Values.ceemsExporter.prometheus.monitor.basicAuth }}
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
{{- with .Values.ceemsExporter.prometheus.monitor.proxyUrl }}
{{- with .Values.ceemsExporter.prometheus.monitor.oauth2 }}
oauth2:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create the namespace name of the pod monitor
*/}}
{{- define "kube-ceems.exporter.podmonitor-namespace" -}}
{{- if .Values.ceemsExporter.namespaceOverride }}
{{- .Values.ceemsExporter.namespaceOverride }}
{{- else }}
{{- if .Values.ceemsExporter.prometheus.podMonitor.namespace }}
{{- .Values.ceemsExporter.prometheus.podMonitor.namespace }}
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
{{- $scheme := .Values.ceemsExporter.prometheus.podMonitor.scheme -}}
{{- if .Values.ceemsExporter.kubeRBACProxy.enabled }}
{{- $defaultAuthorization = dict "type" "Bearer" "credentials" (dict "name" "rbacproxytoken" "key" "token") -}}
{{- $defaultTlsConfig = dict "insecureSkipVerify" true -}}
{{- $scheme = "https" -}}
{{- end }}
{{- $tlsConfig := default $defaultTlsConfig .Values.ceemsExporter.prometheus.podMonitor.tlsConfig -}}
{{- $authorization := default $defaultAuthorization .Values.ceemsExporter.prometheus.podMonitor.authorization -}}
scheme: {{ $scheme }}
{{- with .Values.ceemsExporter.prometheus.podMonitor.basicAuth }}
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
{{- with .Values.ceemsExporter.prometheus.podMonitor.proxyUrl }}
{{- with .Values.ceemsExporter.prometheus.podMonitor.oauth2 }}
oauth2:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Sets manifest that creates secret when kubeRBACProxy is enabled
*/}}
{{- define "kube-ceems.exporter.service-monitor-secret" -}}
{{- if .Values.ceemsExporter.kubeRBACProxy.enabled }}
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: ceems-exporter-servicemonitor-token
  annotations:
    kubernetes.io/service-account.name: {{ include "kube-ceems.exporter.serviceAccountName" . }}
{{- end }}
{{- end }}

{{/*
Create redfish config for ceems exporter
*/}}
{{- define "kube-ceems.exporter.redfish-config" -}}
{{- $config := .Values.ceemsExporter.collectors.redfish.config -}}
{{- if .Values.redfishProxy.enabled -}}
{{- $externalUrl := default (include "kube-ceems.redfish-proxy.svc-url" .) $config.external_url -}}
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
{{- define "kube-ceems.exporter.profiling-config" -}}
ceems_profiler: 
{{- if (hasKey .Values.ceemsExporter.eBPFProfiling.config "ebpf") }}
  ebpf:
{{- with  .Values.ceemsExporter.eBPFProfiling.config.ebpf }}
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- if (hasKey .Values.ceemsExporter.eBPFProfiling.config "pyroscope") }}
  pyroscope:
{{- with  .Values.ceemsExporter.eBPFProfiling.config.pyroscope }}
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- else }}
  pyroscope:
    url: {{ include "kube-ceems.pyroscope-svc-url" . }}
{{- end }}
{{- end }}

{{/*
-------------------------------------------------------------------------------
CEEMS API server related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Fullname suffixed with -api-server 
Adding 9 to 26 truncation of kube-ceems.fullname 
*/}}
{{- define "kube-ceems.api-server.fullname" -}}
{{- if .Values.ceemsAPIServer.fullnameOverride -}}
{{- .Values.ceemsAPIServer.fullnameOverride | trunc 35 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-api-server" (include "kube-ceems.fullname" .) -}}
{{- end }}
{{- end }}

{{/* 
Generate basic labels for ceems-api-server
*/}}
{{- define "kube-ceems.api-server.labels" }}
{{- include "kube-ceems.labels" . }}
app: {{ template "kube-ceems.name" . }}-api-server
app.kubernetes.io/name: {{ template "kube-ceems.name" . }}-api-server
app.kubernetes.io/component: ceems-api-server
{{- end }}

{{/* 
Generate selector labels for ceems-api-server
*/}}
{{- define "kube-ceems.api-server.selectorLabels" -}}
app: {{ template "kube-ceems.name" . }}-api-server
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for ceems-api-server
*/}}
{{- define "kube-ceems.api-server.serviceAccountName" -}}
{{- if .Values.ceemsAPIServer.serviceAccount.create }}
{{- default (include "kube-ceems.api-server.fullname" .) .Values.ceemsAPIServer.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ceemsAPIServer.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Use the ceems-api-server namespace override for multi-namespace deployments in combined charts
*/}}
{{- define "kube-ceems.api-server.namespace" -}}
  {{- if index .Values "ceemsAPIServer" "namespaceOverride" -}}
    {{- index .Values "ceemsAPIServer" "namespaceOverride" -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Data path for ceems api server
*/}}
{{- define "kube-ceems.api-server.data-path" -}}
{{- $path := default "/var/lib/ceems_api_server" .Values.ceemsAPIServer.dataConfig.path -}}
{{- if (isAbs $path) }}
{{- printf "%s" $path }}
{{- else }}
{{- printf "/%s" $path }}
{{- end }}
{{- end }}

{{/*
Create clusters config for ceems api server
*/}}
{{- define "kube-ceems.api-server.clusters-config" -}}
{{- $clusterids := list -}}
{{- $clusterid := (include "kube-ceems.cluster-id" .) -}}
{{- range $_, $value := .Values.ceemsAPIServer.clusters }}
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
{{- define "kube-ceems.api-server.updaters-config" -}}
{{- $updaterids := list -}}
{{- $updaterid := printf "%s-tsdb" (include "kube-ceems.cluster-id" .) -}}
{{- range $_, $value := .Values.ceemsAPIServer.updaters }}
{{- $updaterids = append $updaterids $value.id }}
- {{ tpl (toYaml $value) $  | indent 2 | trim }}
{{- end -}}
{{- if and .Values.monitorCurrentCluster (not (has $updaterid $updaterids)) }}
- id: {{ $updaterid }}
  updater: tsdb
  web:
    url: {{ include "kube-ceems.prometheus-svc-url"  . }}
{{- end }}
{{- end }}

{{/*
Create config for ceems api server
*/}}
{{- define "kube-ceems.api-server.config" -}}
{{- if or .Values.ceemsAPIServer.dataConfig .Values.ceemsAPIServer.adminConfig -}}
ceems_api_server:
{{- if .Values.ceemsAPIServer.dataConfig -}}
{{- $config := .Values.ceemsAPIServer.dataConfig -}}
{{- $_ := set $config "path" (include "kube-ceems.api-server.data-path" .) -}}
{{- with .Values.ceemsAPIServer.dataConfig }}
  data:
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- if .Values.ceemsAPIServer.adminConfig -}}
{{- with .Values.ceemsAPIServer.adminConfig }}
  admin:
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- end }}
{{- if or .Values.ceemsAPIServer.clusters .Values.monitorCurrentCluster }}
clusters:
{{- include "kube-ceems.api-server.clusters-config" . }}
{{- end }}
{{- if or .Values.ceemsAPIServer.updaters .Values.monitorCurrentCluster }}
updaters:
{{- include "kube-ceems.api-server.updaters-config" . }}
{{- end }}
{{- end }}

{{/* 
Generate basic labels for admission-controller
*/}}
{{- define "kube-ceems.api-server.admissionController.labels" }}
{{- include "kube-ceems.labels" . }}
app: {{ template "kube-ceems.name" . }}-admission-controller
app.kubernetes.io/name: {{ template "kube-ceems.name" . }}-admission-controller
app.kubernetes.io/component: ceems-admission-webhook
{{- end }}

{{/* 
Generate selector labels for admission-controller
*/}}
{{- define "kube-ceems.api-server.admissionController.selectorLabels" -}}
app: {{ template "kube-ceems.name" . }}-admission-controller
release: {{ $.Release.Name | quote }}
{{- end }}

{{/* 
TLS config for admission-controller app
*/}}
{{- define "kube-ceems.api-server.admissionController.webConfig" -}}
tls_server_config:
  cert_file: tls.crt
  key_file: tls.key
{{- end }}

{{/* 
Generate service URL for admission-controller app
*/}}
{{- define "kube-ceems.api-server.admissionController.svcURL" -}}
{{ template "kube-ceems.api-server.fullname" . }}.{{ include "kube-ceems.api-server.namespace" . }}.svc
{{- end }}

{{/*
-------------------------------------------------------------------------------
CEEMS LB related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Fullname suffixed with -lb 
Adding 9 to 26 truncation of kube-ceems.fullname 
*/}}
{{- define "kube-ceems.lb.fullname" -}}
{{- if .Values.ceemsLB.fullnameOverride -}}
{{- .Values.ceemsLB.fullnameOverride | trunc 35 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-lb" (include "kube-ceems.fullname" .) -}}
{{- end }}
{{- end }}

{{/* 
Generate basic labels for ceems-lb
*/}}
{{- define "kube-ceems.lb.labels" }}
{{- include "kube-ceems.labels" . }}
app: {{ template "kube-ceems.name" . }}-lb
app.kubernetes.io/name: {{ template "kube-ceems.name" . }}-lb
app.kubernetes.io/component: ceems-prometheus-load-balancer
{{- end }}

{{/* 
Generate selector labels for ceems-lb
*/}}
{{- define "kube-ceems.lb.selectorLabels" -}}
app: {{ template "kube-ceems.name" . }}-lb
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for ceems-lb
*/}}
{{- define "kube-ceems.lb.serviceAccountName" -}}
{{- if .Values.ceemsLB.serviceAccount.create }}
{{- default (include "kube-ceems.lb.fullname" .) .Values.ceemsLB.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ceemsLB.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Use the ceems-lb namespace override for multi-namespace deployments in combined charts
*/}}
{{- define "kube-ceems.lb.namespace" -}}
  {{- if index .Values "ceemsLB" "namespaceOverride" -}}
    {{- index .Values "ceemsLB" "namespaceOverride" -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create config for ceems lb
*/}}
{{- define "kube-ceems.lb.config" -}}
{{- $backendids := list -}}
{{- $clusterid := (include "kube-ceems.cluster-id" .) -}}
ceems_lb:
  strategy: {{ default "round-robin" .Values.ceemsLB.config.strategy }}
{{- if or (hasKey .Values.ceemsLB.config "backends") .Values.monitorCurrentCluster }}
  backends:
{{- range $_, $value := .Values.ceemsLB.config.backends }}
{{- $backendids = append $backendids $value.id }}
  - {{ tpl (toYaml $value) $ | indent 4 | trim }}
{{- end }}
{{- if and .Values.monitorCurrentCluster (not (has $clusterid $backendids)) }}
  - id: {{ $clusterid }}
    tsdb:
      - web:
          url: {{ include "kube-ceems.prometheus-svc-url"  . }}
{{- if and .Values.ceemsExporter.eBPFProfiling.enabled .Values.pyroscopeServer.enabled }}
    pyroscope:
      - web:
          url: {{ include "kube-ceems.pyroscope-svc-url" . }}
{{- end }}
{{- end }}
{{- end }}
{{- if ne .Values.ceemsLB.ceemsAPIServer.persistenceVolumeClaim "" }}
ceems_api_server:
  data:
    path: /var/lib/ceems_api_server
{{- else }}
{{- if not (empty .Values.ceemsLB.ceemsAPIServer.web) }}
ceems_api_server:
  web:
{{- with  .Values.ceemsLB.ceemsAPIServer.web }}
{{ tpl (toYaml .) $ | indent 4 }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Backend server types for ceems lb
*/}}
{{- define "kube-ceems.lb.backend-types" -}}
{{- $backends := list -}}
{{- if (hasKey .Values.ceemsLB.config "backends") }}
{{- range $_, $value := .Values.ceemsLB.config.backends }}
{{- if (hasKey $value "tsdb") }}
{{- $backends = append $backends "tsdb" -}}
{{- end }}
{{- if (hasKey $value "pyroscope") }}
{{- $backends = append $backends "pyroscope" -}}
{{- end }}
{{- end }}
{{- end }}
{{- if .Values.monitorCurrentCluster }}
{{- $backends = append $backends "tsdb" -}}
{{- if and .Values.ceemsExporter.eBPFProfiling.enabled .Values.pyroscopeServer.enabled }}
{{- $backends = append $backends "pyroscope" -}}
{{- end }}
{{- end }}
{{- $backends = $backends | uniq -}}
{{ $backends | join "-" }}
{{- end }}

{{/*
-------------------------------------------------------------------------------
Redfish Proxy related helper variables
-------------------------------------------------------------------------------
*/}}

{{/* 
Fullname suffixed with -redfish-proxy 
Adding 9 to 26 truncation of kube-ceems.fullname 
*/}}
{{- define "kube-ceems.redfish-proxy.fullname" -}}
{{- if .Values.redfishProxy.fullnameOverride -}}
{{- .Values.redfishProxy.fullnameOverride | trunc 35 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-redfish-proxy" (include "kube-ceems.fullname" .) -}}
{{- end }}
{{- end }}

{{/* 
Generate basic labels for redfish-proxy
*/}}
{{- define "kube-ceems.redfish-proxy.labels" }}
{{- include "kube-ceems.labels" . }}
app: {{ template "kube-ceems.name" . }}-redfish-proxy
app.kubernetes.io/name: {{ template "kube-ceems.name" . }}-redfish-proxy
app.kubernetes.io/component: proxy
{{- end }}

{{/* 
Generate selector labels for redfish-proxy
*/}}
{{- define "kube-ceems.redfish-proxy.selectorLabels" -}}
app: {{ template "kube-ceems.name" . }}-redfish-proxy
release: {{ $.Release.Name | quote }}
{{- end }}

{{/*
Create the name of the service account to use for redfish-proxy
*/}}
{{- define "kube-ceems.redfish-proxy.serviceAccountName" -}}
{{- if .Values.redfishProxy.serviceAccount.create }}
{{- default (include "kube-ceems.redfish-proxy.fullname" .) .Values.redfishProxy.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.redfishProxy.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Use the redfish-proxy namespace override for multi-namespace deployments in combined charts
*/}}
{{- define "kube-ceems.redfish-proxy.namespace" -}}
  {{- if index .Values "redfishProxy" "namespaceOverride" -}}
    {{- index .Values "redfishProxy" "namespaceOverride" -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/* 
Service URL of redfish-proxy that is accessible from exporter pods
*/}}
{{- define "kube-ceems.redfish-proxy.svc-url" -}}
{{- $servicePort := .Values.redfishProxy.service.port -}}
{{- $protocol := "http" -}}
{{- if .Values.redfishProxy.kubeRBACProxy.enabled -}}
{{- $protocol = "https" -}}
{{- end }}
{{- printf "%s://%s.%s.svc:%d" $protocol (include "kube-ceems.redfish-proxy.fullname" .) (include "kube-ceems.redfish-proxy.namespace" .) ($servicePort | int) -}}
{{- end }}

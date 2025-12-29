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
CEEMS current cluster id
*/}}
{{- define "ceems-lb.cluster-id" -}}
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
{{- define "ceems-lb.kube-prometheus-stack.fullname" -}}
{{- printf "%s-kube-prometheus-stack" .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- end -}}

{{/*
Prometheus service URL
*/}}
{{- define "ceems-lb.prometheus-svc-url" -}}
http://{{ include "ceems-lb.kube-prometheus-stack.fullname" . }}-prometheus.{{ include "ceems-lb.namespace" . }}:9090
{{- end }}

{{/*
Pyroscope fullname based on its default value
*/}}
{{- define "ceems-lb.pyroscope.fullname" -}}
{{- printf "%s-pyroscope" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Pyroscope service URL
*/}}
{{- define "ceems-lb.pyroscope-svc-url" -}}
http://{{ include "ceems-lb.pyroscope.fullname" . }}.{{ include "ceems-lb.namespace" . }}:4040
{{- end }}

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
{{- $backendids := list -}}
{{- $clusterid := (include "ceems-lb.cluster-id" .) -}}
ceems_lb:
  strategy: {{ default "round-robin" .Values.config.strategy }}
{{- if or (hasKey .Values.config "backends") .Values.monitorCurrentCluster }}
  backends:
{{- range $_, $value := .Values.config.backends }}
{{- $backendids = append $backendids $value.id }}
  - {{ tpl (toYaml $value) $ | indent 4 | trim }}
{{- end }}
{{- if and (index .Values "ceems-api-server") (index .Values "ceems-api-server" "monitoring" "enabled") (not (has $clusterid $backendids)) }}
  - id: {{ $clusterid }}
    tsdb:
      - web:
          url: {{ include "ceems-lb.prometheus-svc-url" . }}
{{- if and (index .Values "ceems-exporter" "eBPFProfiling" "enabled") (index .Values "pyroscopeServer" "enabled") }}
    pyroscope:
      - web:
          url: {{ include "ceems-lb.pyroscope-svc-url" . }}
{{- end }}
{{- end }}
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
{{- if and (index .Values "ceems-api-server") (index .Values "ceems-api-server" "monitoring" "enabled") }}
{{- $backends = append $backends "tsdb" -}}
{{- if and (index .Values "ceems-exporter" "eBPFProfiling" "enabled") (index .Values "pyroscopeServer" "enabled") }}
{{- $backends = append $backends "pyroscope" -}}
{{- end }}
{{- end }}
{{- $backends = $backends | uniq -}}
{{ $backends | join "-" }}
{{- end }}

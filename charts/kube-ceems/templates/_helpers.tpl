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
{{- default (printf "%s-k8s-0" .Release.Name) (index .Values "ceems-api-server" "monitoring" "clusterID") }}
{{- end }}

{{/*
-------------------------------------------------------------------------------
Templates copied from children charts for generating service URLs
-------------------------------------------------------------------------------
*/}}

{{/*
ceems-api-server fullname based on its default value
*/}}
{{- define "kube-ceems.ceems-api-server.fullname" -}}
{{- printf "%s-ceems-api-server" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
kube-prometheus-stack fullname based on its default value
*/}}
{{- define "kube-ceems.kube-prometheus-stack.fullname" -}}
{{- printf "%s-kube-prometheus-stack" .Release.Name | trunc 26 | trimSuffix "-" -}}
{{- end -}}

{{/*
Prometheus service host
*/}}
{{- define "kube-ceems.prometheus-svc-host" -}}
{{ include "kube-ceems.kube-prometheus-stack.fullname" . }}-prometheus.{{ include "kube-ceems.namespace" . }}
{{- end }}

{{/*
Pyroscope fullname based on its default value in the parent chart
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
Pyroscope service host
*/}}
{{- define "kube-ceems.pyroscope-svc-host" -}}
{{ include "kube-ceems.pyroscope.fullname" . }}.{{ include "kube-ceems.namespace" . }}
{{- end }}

{{/*
Pyroscope service URL
*/}}
{{- define "kube-ceems.pyroscope-svc-url" -}}
http://{{ include "kube-ceems.pyroscope-svc-host" . }}:4040
{{- end }}

{{/*
-------------------------------------------------------------------------------
CEEMS LB
-------------------------------------------------------------------------------
*/}}

{{/*
Create config for ceems lb
*/}}
{{- define "kube-ceems.lb.config" -}}
{{- $backendids := list -}}
{{- $clusterid := (include "ceems-api-server.cluster-id" (index .Subcharts "ceems-api-server")) -}}
ceems_lb:
  strategy: {{ default "round-robin" (index .Values "ceems-lb" "config" "strategy") }}
{{- if or (hasKey (index .Values "ceems-lb" "config") "backends") (index .Values "ceems-api-server" "monitoring" "enabled") }}
  backends:
{{- range $_, $value := (index .Values "ceems-lb" "config" "backends") }}
{{- $backendids = append $backendids $value.id }}
  - {{ tpl (toYaml $value) $ | indent 4 | trim }}
{{- end }}
{{- if and (index .Values "ceems-api-server" "monitoring" "enabled") (not (has $clusterid $backendids)) }}
  - id: {{ $clusterid }}
    tsdb:
      - web:
          url: http://{{ include "kube-ceems.prometheus-svc-host" . }}:9090
{{- if and (index .Values "ceems-exporter" "eBPFProfiling" "enabled") (index .Values "pyroscopeServer" "enabled") }}
    pyroscope:
      - web:
          url: http://{{ include "kube-ceems.pyroscope-svc-host" . }}:4040
{{- end }}
{{- end }}
{{- end }}
{{- if ne (index .Values "ceems-lb" "ceemsAPIServer" "persistenceVolumeClaim") "" }}
ceems_api_server:
  data:
    path: /var/lib/ceems_api_server
{{- else }}
{{- if not (empty (index .Values "ceems-lb" "ceemsAPIServer" "web")) }}
ceems_api_server:
  web:
{{- with  (index .Values "ceems-lb" "ceemsAPIServer" "web") }}
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
{{- if (hasKey (index .Values "ceems-lb" "config") "backends") }}
{{- range $_, $value := (index .Values "ceems-lb" "config" "backends") }}
{{- if (hasKey $value "tsdb") }}
{{- $backends = append $backends "tsdb" -}}
{{- end }}
{{- if (hasKey $value "pyroscope") }}
{{- $backends = append $backends "pyroscope" -}}
{{- end }}
{{- end }}
{{- end }}
{{- if (index .Values "ceems-api-server" "monitoring" "enabled") }}
{{- $backends = append $backends "tsdb" -}}
{{- if and (index .Values "ceems-exporter" "eBPFProfiling" "enabled") (index .Values "pyroscopeServer" "enabled") }}
{{- $backends = append $backends "pyroscope" -}}
{{- end }}
{{- end }}
{{- $backends = $backends | uniq -}}
{{ $backends | join "-" }}
{{- end }}

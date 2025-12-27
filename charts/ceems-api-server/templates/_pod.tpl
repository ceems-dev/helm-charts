{{- define "ceems-api-server.pod" -}}
{{- $sts := list "sts" "StatefulSet" "statefulset" -}}
{{- $root := . -}}
automountServiceAccountToken: true
{{- with .Values.priorityClassName }}
priorityClassName: {{ . }}
{{- end }}
{{- with .Values.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.extraInitContainers }}
initContainers:
  {{- toYaml . | nindent 2 }}
{{- end }}
serviceAccountName: {{ include "ceems-api-server.serviceAccountName" . }}
{{- with .Values.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
containers:
  {{- $servicePort := ternary .Values.kubeRBACProxy.port .Values.service.port .Values.kubeRBACProxy.enabled }}
  - name: ceems-api-server
    image: {{ include "ceems-api-server.image" . }}
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    command:
      - /bin/ceems_api_server
    args:
      - --web.listen-address=[$(HOST_IP)]:{{ $servicePort }}
      - --config.file=/etc/ceems-api-server/config.yaml
      {{- if not (empty .Values.webConfig) }}
      - --web.config.file=/etc/ceems-web/config.yaml
      {{- end }}
      {{- range $_, $arg := .Values.additionalArgs }}
      {{- if (hasKey $arg "value") }}
      - --{{ $arg.name }}={{ $arg.value }}
      {{- else }}
      - --{{ $arg.name }}
      {{- end }}
      {{- end }}
    {{- with .Values.containerSecurityContext }}
    securityContext:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    env:
      - name: NODE_NAME
        valueFrom:
          fieldRef:
            fieldPath: spec.nodeName
      - name: POD_NAMESPACE
        valueFrom:
          fieldRef:
            fieldPath: metadata.namespace
      - name: HOST_IP
        {{- if .Values.kubeRBACProxy.enabled }}
        value: 127.0.0.1
        {{- else if .Values.service.listenOnAllInterfaces }}
        value: 0.0.0.0
        {{- else }}
        valueFrom:
          fieldRef:
            apiVersion: v1
            fieldPath: status.hostIP
        {{- end }}
      {{- range $key, $value := .Values.env }}
      - name: {{ $key }}
        value: {{ $value | quote }}
      {{- end }}
    {{- if eq .Values.kubeRBACProxy.enabled false }}
    ports:
      - name: {{ .Values.service.portName }}
        containerPort: {{ .Values.service.port }}
        protocol: TCP
    {{- end }}
    livenessProbe:
      failureThreshold: {{ .Values.livenessProbe.failureThreshold }}
      exec:
        command:
          - /bin/liveness-probe.sh
          - -a
          - ceems_api_server
          - -p
          - {{ $servicePort | quote }}
      initialDelaySeconds: {{ .Values.livenessProbe.initialDelaySeconds }}
      periodSeconds: {{ .Values.livenessProbe.periodSeconds }}
      successThreshold: {{ .Values.livenessProbe.successThreshold }}
      timeoutSeconds: {{ .Values.livenessProbe.timeoutSeconds }}
    readinessProbe:
      failureThreshold: {{ .Values.readinessProbe.failureThreshold }}
      exec:
        command:
          - /bin/liveness-probe.sh
          - -a
          - ceems_api_server
          - -p
          - {{ $servicePort | quote }}
      initialDelaySeconds: {{ .Values.readinessProbe.initialDelaySeconds }}
      periodSeconds: {{ .Values.readinessProbe.periodSeconds }}
      successThreshold: {{ .Values.readinessProbe.successThreshold }}
      timeoutSeconds: {{ .Values.readinessProbe.timeoutSeconds }}
    {{- with .Values.resources }}
    resources:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- if .Values.terminationMessageParams.enabled }}
    {{- with .Values.terminationMessageParams }}
    terminationMessagePath: {{ .terminationMessagePath }}
    terminationMessagePolicy: {{ .terminationMessagePolicy }}
    {{- end }}
    {{- end }}
    volumeMounts:
      - name: ceems-api-server-config
        mountPath: /etc/ceems-api-server
      {{- if not (empty .Values.webConfig) }}
      - name: ceems-api-server-web-config
        mountPath: /etc/ceems-web
      {{- end }}
      - name: storage
        mountPath: {{ include "ceems-api-server.data-path" . | nindent 10 }}
        {{- with .Values.persistence.subPath }}
        subPath: {{ tpl . $ }}
        {{- end }}
      {{- range $_, $mount := .Values.extraHostVolumeMounts }}
      - name: {{ $mount.name }}
        mountPath: {{ $mount.mountPath }}
        readOnly: {{ $mount.readOnly }}
        {{- with $mount.mountPropagation }}
        mountPropagation: {{ . }}
        {{- end -}}
      {{- end -}}
      {{- range $_, $mount := .Values.configmaps }}
      - name: {{ tpl $mount.name $ | quote}}
        mountPath: {{ $mount.mountPath }}
      {{- end }}
      {{- range $_, $mount := .Values.secrets }}
      - name: {{ tpl $mount.name $ | quote }}
        mountPath: {{ $mount.mountPath }}
      {{- end }}
      {{- with .Values.extraVolumeMounts }}
      {{- toYaml . | nindent 6 }}
      {{- end }}
  {{-  if .Values.kubeRBACProxy.enabled  }}
  - name: kube-rbac-proxy
    args:
      {{- range $_, $arg := .Values.kubeRBACProxy.additionalArgs }}
      {{- if (hasKey $arg "value") }}
      - --{{ $arg.name }}={{ $arg.value }}
      {{- else }}
      - --{{ $arg.name }}
      {{- end }}
      {{- end }}
      - --secure-listen-address=:{{ .Values.service.port }}
      - --upstream=http://127.0.0.1:{{ $servicePort }}/
      - --proxy-endpoints-port={{ .Values.kubeRBACProxy.proxyEndpointsPort }}
      - --config-file=/etc/kube-rbac-proxy-config/config-file.yaml
      {{- if and .Values.kubeRBACProxy.tls.enabled .Values.tlsSecret.enabled }}
      - --tls-cert-file=/tls/private/{{ .Values.tlsSecret.certItem }}
      - --tls-private-key-file=/tls/private/{{ .Values.tlsSecret.keyItem }}
      {{- if and .Values.kubeRBACProxy.tls.tlsClientAuth .Values.tlsSecret.caItem }}
      - --client-ca-file=/tls/private/{{ .Values.tlsSecret.caItem }}
      {{- end }}
      {{- end }}
    volumeMounts:
      - name: kube-rbac-proxy-config
        mountPath: /etc/kube-rbac-proxy-config
      {{- if and .Values.kubeRBACProxy.tls.enabled .Values.tlsSecret.enabled }}
      - name: {{ tpl .Values.tlsSecret.volumeName . | quote }}
        mountPath: /tls/private
        readOnly: true
      {{- end }}
      {{- with .Values.kubeRBACProxy.extraVolumeMounts }}
      {{- toYaml . | nindent 6 }}
      {{- end }}
    imagePullPolicy: {{ .Values.kubeRBACProxy.image.pullPolicy }}
    {{- if .Values.kubeRBACProxy.image.sha }}
    image: "{{ .Values.imageRegistry | default .Values.kubeRBACProxy.image.registry}}/{{ .Values.kubeRBACProxy.image.repository }}:{{ .Values.kubeRBACProxy.image.tag }}@sha256:{{ .Values.kubeRBACProxy.image.sha }}"
    {{- else }}
    image: "{{ .Values.imageRegistry | default .Values.kubeRBACProxy.image.registry}}/{{ .Values.kubeRBACProxy.image.repository }}:{{ .Values.kubeRBACProxy.image.tag }}"
    {{- end }}
    ports:
      - containerPort: {{ .Values.service.port}}
        name: {{ .Values.kubeRBACProxy.portName }}
        {{- if .Values.kubeRBACProxy.enableHostPort }}
        hostPort: {{ .Values.service.port }}
        {{- end }}
      - containerPort: {{ .Values.kubeRBACProxy.proxyEndpointsPort }}
        {{- if .Values.kubeRBACProxy.enableProxyEndpointsHostPort }}
        hostPort: {{ .Values.kubeRBACProxy.proxyEndpointsPort }}
        {{- end }}
        name: "http-healthz"
    readinessProbe:
      httpGet:
        scheme: HTTPS
        port: {{ .Values.kubeRBACProxy.proxyEndpointsPort }}
        path: healthz
      initialDelaySeconds: 5
      timeoutSeconds: 5
    {{- if .Values.kubeRBACProxy.resources }}
    resources:
      {{- toYaml .Values.kubeRBACProxy.resources | nindent 6 }}
    {{- end }}
    {{- if .Values.terminationMessageParams.enabled }}
    {{- with .Values.terminationMessageParams }}
    terminationMessagePath: {{ .terminationMessagePath }}
    terminationMessagePolicy: {{ .terminationMessagePolicy }}
    {{- end }}
    {{- end }}
    {{- with .Values.kubeRBACProxy.env }}
    env:
      {{- range $key, $value := $.Values.kubeRBACProxy.env }}
      - name: {{ $key }}
        value: {{ $value | quote }}
      {{- end }}
    {{- end }}
    {{- with .Values.kubeRBACProxy.containerSecurityContext }}
    securityContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}
  {{- end }}
{{- if or .Values.imagePullSecrets .Values.imagePullSecrets }}
imagePullSecrets:
  {{- include "ceems-api-server.imagePullSecrets" (dict "Values" .Values.ceemsAPIServer "imagePullSecrets" .Values.imagePullSecrets) | indent 2 }}
{{- end }}
{{- with .Values.affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.dnsConfig }}
dnsConfig:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.restartPolicy }}
restartPolicy: {{ . }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
volumes:
  - name: ceems-api-server-config
    secret:
      secretName: {{ template "ceems-api-server.fullname" . }}-config
  {{- if not (empty .Values.webConfig) }}
  - name: ceems-api-server-web-config
    secret:
      secretName: {{ template "ceems-api-server.fullname" . }}-web-config
  {{- end }}
  {{- if and .Values.persistence.enabled (eq .Values.persistence.type "pvc") }}
  - name: storage
    persistentVolumeClaim:
      claimName: {{ tpl (.Values.persistence.existingClaim | default (include "ceems-api-server.fullname" .)) . }}
  {{- else if and .Values.persistence.enabled (has .Values.persistence.type $sts) }}
  {{/* nothing */}}
  {{- else }}
  - name: storage
    {{- if .Values.persistence.inMemory.enabled }}
    emptyDir:
      medium: Memory
      {{- with .Values.persistence.inMemory.sizeLimit }}
      sizeLimit: {{ . }}
      {{- end }}
    {{- else }}
    emptyDir: {}
    {{- end }}
  {{- end }}
  {{- range $_, $mount := .Values.extraHostVolumeMounts }}
  - name: {{ $mount.name }}
    hostPath:
      path: {{ $mount.hostPath }}
      {{- with $mount.type }}
      type: {{ . }}
      {{- end }}
  {{- end -}}
  {{- range $_, $mount := .Values.configmaps }}
  - name: {{ tpl $mount.name $ | quote }}
    configMap:
      name: {{ tpl $mount.name $ | quote }}
  {{- end }}
  {{- range $_, $mount := .Values.secrets }}
  - name: {{ tpl $mount.name $ | quote }}
    secret:
      secretName: {{tpl $mount.name $ | quote }}
  {{- end }}
  {{- if .Values.kubeRBACProxy.enabled }}
  - name: kube-rbac-proxy-config
    configMap:
      name: {{ template "ceems-api-server.fullname" . }}-rbac-config
  {{- end }}
  {{- if .Values.tlsSecret.enabled }}
  - name: {{ tpl .Values.tlsSecret.volumeName . | quote }}
    secret:
      secretName: {{ tpl .Values.tlsSecret.secretName . | quote }}
      items:
        - key: {{ required "Value tlsSecret.certItem must be set." .Values.tlsSecret.certItem | quote }}
          path: {{ .Values.tlsSecret.certItem | quote }}
        - key: {{ required "Value tlsSecret.keyItem must be set." .Values.tlsSecret.keyItem | quote }}
          path: {{ .Values.tlsSecret.keyItem | quote }}
        {{- if .Values.tlsSecret.caItem }}
        - key: {{ .Values.tlsSecret.caItem | quote }}
          path: {{ .Values.tlsSecret.caItem | quote }}
        {{- end }}
  {{- end }}
  {{- with .Values.extraVolumes }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}

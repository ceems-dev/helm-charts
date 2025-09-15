{{- define "ceems-api-server.pod" -}}
{{- $sts := list "sts" "StatefulSet" "statefulset" -}}
{{- $root := . -}}
automountServiceAccountToken: true
{{- with .Values.ceemsAPIServer.priorityClassName }}
priorityClassName: {{ . }}
{{- end }}
{{- with .Values.ceemsAPIServer.securityContext }}
securityContext:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.ceemsAPIServer.extraInitContainers }}
initContainers:
  {{- toYaml . | nindent 2 }}
{{- end }}
serviceAccountName: {{ include "kube-ceems.api-server.serviceAccountName" . }}
{{- with .Values.ceemsAPIServer.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ . }}
{{- end }}
containers:
  {{- $servicePort := ternary .Values.ceemsAPIServer.kubeRBACProxy.port .Values.ceemsAPIServer.service.port .Values.ceemsAPIServer.kubeRBACProxy.enabled }}
  - name: ceems-api-server
    image: {{ include "kube-ceems.image" . }}
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    command:
      - /bin/ceems_api_server
    args:
      - --web.listen-address=[$(HOST_IP)]:{{ $servicePort }}
      - --config.file=/etc/ceems-api-server/config.yaml
      {{- if not (empty .Values.ceemsAPIServer.webConfig) }}
      - --web.config.file=/etc/ceems-web/config.yaml
      {{- end }}
      {{- range $_, $arg := .Values.ceemsAPIServer.additionalArgs }}
      {{- if (hasKey $arg "value") }}
      - --{{ $arg.name }}={{ $arg.value }}
      {{- else }}
      - --{{ $arg.name }}
      {{- end }}
      {{- end }}
    {{- with .Values.ceemsAPIServer.containerSecurityContext }}
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
        {{- if .Values.ceemsAPIServer.kubeRBACProxy.enabled }}
        value: 127.0.0.1
        {{- else if .Values.ceemsAPIServer.service.listenOnAllInterfaces }}
        value: 0.0.0.0
        {{- else }}
        valueFrom:
          fieldRef:
            apiVersion: v1
            fieldPath: status.hostIP
        {{- end }}
      {{- range $key, $value := .Values.ceemsAPIServer.env }}
      - name: {{ $key }}
        value: {{ $value | quote }}
      {{- end }}
    {{- if eq .Values.ceemsAPIServer.kubeRBACProxy.enabled false }}
    ports:
      - name: {{ .Values.ceemsAPIServer.service.portName }}
        containerPort: {{ .Values.ceemsAPIServer.service.port }}
        protocol: TCP
    {{- end }}
    livenessProbe:
      failureThreshold: {{ .Values.ceemsAPIServer.livenessProbe.failureThreshold }}
      exec:
        command:
          - /bin/liveness-probe.sh
          - -a
          - ceems_api_server
          - -p
          - {{ $servicePort | quote }}
      initialDelaySeconds: {{ .Values.ceemsAPIServer.livenessProbe.initialDelaySeconds }}
      periodSeconds: {{ .Values.ceemsAPIServer.livenessProbe.periodSeconds }}
      successThreshold: {{ .Values.ceemsAPIServer.livenessProbe.successThreshold }}
      timeoutSeconds: {{ .Values.ceemsAPIServer.livenessProbe.timeoutSeconds }}
    readinessProbe:
      failureThreshold: {{ .Values.ceemsAPIServer.readinessProbe.failureThreshold }}
      exec:
        command:
          - /bin/liveness-probe.sh
          - -a
          - ceems_api_server
          - -p
          - {{ $servicePort | quote }}
      initialDelaySeconds: {{ .Values.ceemsAPIServer.readinessProbe.initialDelaySeconds }}
      periodSeconds: {{ .Values.ceemsAPIServer.readinessProbe.periodSeconds }}
      successThreshold: {{ .Values.ceemsAPIServer.readinessProbe.successThreshold }}
      timeoutSeconds: {{ .Values.ceemsAPIServer.readinessProbe.timeoutSeconds }}
    {{- with .Values.ceemsAPIServer.resources }}
    resources:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- if .Values.ceemsAPIServer.terminationMessageParams.enabled }}
    {{- with .Values.ceemsAPIServer.terminationMessageParams }}
    terminationMessagePath: {{ .terminationMessagePath }}
    terminationMessagePolicy: {{ .terminationMessagePolicy }}
    {{- end }}
    {{- end }}
    volumeMounts:
      - name: ceems-api-server-config
        mountPath: /etc/ceems-api-server
      {{- if not (empty .Values.ceemsAPIServer.webConfig) }}
      - name: ceems-api-server-web-config
        mountPath: /etc/ceems-web
      {{- end }}
      - name: storage
        mountPath: {{ include "kube-ceems.api-server.data-path" . | nindent 10 }}
        {{- with .Values.ceemsAPIServer.persistence.subPath }}
        subPath: {{ tpl . $ }}
        {{- end }}
      {{- range $_, $mount := .Values.ceemsAPIServer.extraHostVolumeMounts }}
      - name: {{ $mount.name }}
        mountPath: {{ $mount.mountPath }}
        readOnly: {{ $mount.readOnly }}
        {{- with $mount.mountPropagation }}
        mountPropagation: {{ . }}
        {{- end -}}
      {{- end -}}
      {{- range $_, $mount := .Values.ceemsAPIServer.configmaps }}
      - name: {{ tpl $mount.name $ | quote}}
        mountPath: {{ $mount.mountPath }}
      {{- end }}
      {{- range $_, $mount := .Values.ceemsAPIServer.secrets }}
      - name: {{ tpl $mount.name $ | quote }}
        mountPath: {{ $mount.mountPath }}
      {{- end }}
      {{- with .Values.ceemsAPIServer.extraVolumeMounts }}
      {{- toYaml . | nindent 6 }}
      {{- end }}
  {{-  if .Values.ceemsAPIServer.kubeRBACProxy.enabled  }}
  - name: kube-rbac-proxy
    args:
      {{- range $_, $arg := .Values.ceemsAPIServer.kubeRBACProxy.additionalArgs }}
      {{- if (hasKey $arg "value") }}
      - --{{ $arg.name }}={{ $arg.value }}
      {{- else }}
      - --{{ $arg.name }}
      {{- end }}
      {{- end }}
      - --secure-listen-address=:{{ .Values.ceemsAPIServer.service.port }}
      - --upstream=http://127.0.0.1:{{ $servicePort }}/
      - --proxy-endpoints-port={{ .Values.ceemsAPIServer.kubeRBACProxy.proxyEndpointsPort }}
      - --config-file=/etc/kube-rbac-proxy-config/config-file.yaml
      {{- if and .Values.ceemsAPIServer.kubeRBACProxy.tls.enabled .Values.ceemsAPIServer.tlsSecret.enabled }}
      - --tls-cert-file=/tls/private/{{ .Values.ceemsAPIServer.tlsSecret.certItem }}
      - --tls-private-key-file=/tls/private/{{ .Values.ceemsAPIServer.tlsSecret.keyItem }}
      {{- if and .Values.ceemsAPIServer.kubeRBACProxy.tls.tlsClientAuth .Values.ceemsAPIServer.tlsSecret.caItem }}
      - --client-ca-file=/tls/private/{{ .Values.ceemsAPIServer.tlsSecret.caItem }}
      {{- end }}
      {{- end }}
    volumeMounts:
      - name: kube-rbac-proxy-config
        mountPath: /etc/kube-rbac-proxy-config
      {{- if and .Values.ceemsAPIServer.kubeRBACProxy.tls.enabled .Values.ceemsAPIServer.tlsSecret.enabled }}
      - name: {{ tpl .Values.ceemsAPIServer.tlsSecret.volumeName . | quote }}
        mountPath: /tls/private
        readOnly: true
      {{- end }}
      {{- with .Values.ceemsAPIServer.kubeRBACProxy.extraVolumeMounts }}
      {{- toYaml . | nindent 6 }}
      {{- end }}
    imagePullPolicy: {{ .Values.ceemsAPIServer.kubeRBACProxy.image.pullPolicy }}
    {{- if .Values.ceemsAPIServer.kubeRBACProxy.image.sha }}
    image: "{{ .Values.ceemsAPIServer.imageRegistry | default .Values.ceemsAPIServer.kubeRBACProxy.image.registry}}/{{ .Values.ceemsAPIServer.kubeRBACProxy.image.repository }}:{{ .Values.ceemsAPIServer.kubeRBACProxy.image.tag }}@sha256:{{ .Values.ceemsAPIServer.kubeRBACProxy.image.sha }}"
    {{- else }}
    image: "{{ .Values.ceemsAPIServer.imageRegistry | default .Values.ceemsAPIServer.kubeRBACProxy.image.registry}}/{{ .Values.ceemsAPIServer.kubeRBACProxy.image.repository }}:{{ .Values.ceemsAPIServer.kubeRBACProxy.image.tag }}"
    {{- end }}
    ports:
      - containerPort: {{ .Values.ceemsAPIServer.service.port}}
        name: {{ .Values.ceemsAPIServer.kubeRBACProxy.portName }}
        {{- if .Values.ceemsAPIServer.kubeRBACProxy.enableHostPort }}
        hostPort: {{ .Values.ceemsAPIServer.service.port }}
        {{- end }}
      - containerPort: {{ .Values.ceemsAPIServer.kubeRBACProxy.proxyEndpointsPort }}
        {{- if .Values.ceemsAPIServer.kubeRBACProxy.enableProxyEndpointsHostPort }}
        hostPort: {{ .Values.ceemsAPIServer.kubeRBACProxy.proxyEndpointsPort }}
        {{- end }}
        name: "http-healthz"
    readinessProbe:
      httpGet:
        scheme: HTTPS
        port: {{ .Values.ceemsAPIServer.kubeRBACProxy.proxyEndpointsPort }}
        path: healthz
      initialDelaySeconds: 5
      timeoutSeconds: 5
    {{- if .Values.ceemsAPIServer.kubeRBACProxy.resources }}
    resources:
      {{- toYaml .Values.ceemsAPIServer.kubeRBACProxy.resources | nindent 6 }}
    {{- end }}
    {{- if .Values.ceemsAPIServer.terminationMessageParams.enabled }}
    {{- with .Values.ceemsAPIServer.terminationMessageParams }}
    terminationMessagePath: {{ .terminationMessagePath }}
    terminationMessagePolicy: {{ .terminationMessagePolicy }}
    {{- end }}
    {{- end }}
    {{- with .Values.ceemsAPIServer.kubeRBACProxy.env }}
    env:
      {{- range $key, $value := $.Values.ceemsAPIServer.kubeRBACProxy.env }}
      - name: {{ $key }}
        value: {{ $value | quote }}
      {{- end }}
    {{- end }}
    {{- with .Values.ceemsAPIServer.kubeRBACProxy.containerSecurityContext }}
    securityContext:
      {{ toYaml . | nindent 6 }}
    {{- end }}
  {{- end }}
{{- if or .Values.ceemsAPIServer.imagePullSecrets .Values.ceemsAPIServer.imagePullSecrets }}
imagePullSecrets:
  {{- include "kube-ceems.imagePullSecrets" (dict "Values" .Values.ceemsAPIServer "imagePullSecrets" .Values.ceemsAPIServer.imagePullSecrets) | indent 2 }}
{{- end }}
{{- with .Values.ceemsAPIServer.affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.ceemsAPIServer.dnsConfig }}
dnsConfig:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.ceemsAPIServer.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.ceemsAPIServer.restartPolicy }}
restartPolicy: {{ . }}
{{- end }}
{{- with .Values.ceemsAPIServer.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
volumes:
  - name: ceems-api-server-config
    secret:
      secretName: {{ template "kube-ceems.api-server.fullname" . }}-config
  {{- if not (empty .Values.ceemsAPIServer.webConfig) }}
  - name: ceems-api-server-web-config
    secret:
      secretName: {{ template "kube-ceems.api-server.fullname" . }}-web-config
  {{- end }}
  {{- if and .Values.ceemsAPIServer.persistence.enabled (eq .Values.ceemsAPIServer.persistence.type "pvc") }}
  - name: storage
    persistentVolumeClaim:
      claimName: {{ tpl (.Values.ceemsAPIServer.persistence.existingClaim | default (include "kube-ceems.api-server.fullname" .)) . }}
  {{- else if and .Values.ceemsAPIServer.persistence.enabled (has .Values.ceemsAPIServer.persistence.type $sts) }}
  {{/* nothing */}}
  {{- else }}
  - name: storage
    {{- if .Values.ceemsAPIServer.persistence.inMemory.enabled }}
    emptyDir:
      medium: Memory
      {{- with .Values.ceemsAPIServer.persistence.inMemory.sizeLimit }}
      sizeLimit: {{ . }}
      {{- end }}
    {{- else }}
    emptyDir: {}
    {{- end }}
  {{- end }}
  {{- range $_, $mount := .Values.ceemsAPIServer.extraHostVolumeMounts }}
  - name: {{ $mount.name }}
    hostPath:
      path: {{ $mount.hostPath }}
      {{- with $mount.type }}
      type: {{ . }}
      {{- end }}
  {{- end -}}
  {{- range $_, $mount := .Values.ceemsAPIServer.configmaps }}
  - name: {{ tpl $mount.name $ | quote }}
    configMap:
      name: {{ tpl $mount.name $ | quote }}
  {{- end }}
  {{- range $_, $mount := .Values.ceemsAPIServer.secrets }}
  - name: {{ tpl $mount.name $ | quote }}
    secret:
      secretName: {{tpl $mount.name $ | quote }}
  {{- end }}
  {{- if .Values.ceemsAPIServer.kubeRBACProxy.enabled }}
  - name: kube-rbac-proxy-config
    configMap:
      name: {{ template "kube-ceems.api-server.fullname" . }}-rbac-config
  {{- end }}
  {{- if .Values.ceemsAPIServer.tlsSecret.enabled }}
  - name: {{ tpl .Values.ceemsAPIServer.tlsSecret.volumeName . | quote }}
    secret:
      secretName: {{ tpl .Values.ceemsAPIServer.tlsSecret.secretName . | quote }}
      items:
        - key: {{ required "Value tlsSecret.certItem must be set." .Values.ceemsAPIServer.tlsSecret.certItem | quote }}
          path: {{ .Values.ceemsAPIServer.tlsSecret.certItem | quote }}
        - key: {{ required "Value tlsSecret.keyItem must be set." .Values.ceemsAPIServer.tlsSecret.keyItem | quote }}
          path: {{ .Values.ceemsAPIServer.tlsSecret.keyItem | quote }}
        {{- if .Values.ceemsAPIServer.tlsSecret.caItem }}
        - key: {{ .Values.ceemsAPIServer.tlsSecret.caItem | quote }}
          path: {{ .Values.ceemsAPIServer.tlsSecret.caItem | quote }}
        {{- end }}
  {{- end }}
  {{- with .Values.ceemsAPIServer.extraVolumes }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}

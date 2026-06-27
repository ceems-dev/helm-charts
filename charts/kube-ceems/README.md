<!-- textlint-disable -->

# kube-ceems

![Version: 1.9.0](https://img.shields.io/badge/Version-1.9.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.14.3](https://img.shields.io/badge/AppVersion-0.14.3-informational?style=flat-square)

A Helm chart for deploying CEEMS

**Homepage:** <https://ceems-dev.github.io/helm-charts/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mahendrapaipuri | <mahendra.paipuri@gmail.com> | <https://github.com/mahendrapaipuri> |

## Source Code

* <https://github.com/ceems-dev/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://ceems-dev.github.io/helm-charts | ceems-api-server | 0.7.4 |
| https://ceems-dev.github.io/helm-charts | ceems-exporter | 0.6.3 |
| https://ceems-dev.github.io/helm-charts | ceems-lb | 0.6.3 |
| https://grafana.github.io/helm-charts | pyroscope | 2.1.0 |
| https://prometheus-community.github.io/helm-charts | kube-prometheus-stack | 87.3.* |

<!-- textlint-enable -->

## Description

Installs core components of the [CEEMS](https://ceems-dev.github.io/ceems/docs/), a collection of Kubernetes manifests,
Grafana dashboards, and Prometheus rules combined with documentation and scripts to provide easy to operate end-to-end
Kubernetes cluster energy and emissions monitoring with Prometheus and Grafana.

## Prerequisites

* Kubernetes 1.19+
* Helm 3+

## Usage

The chart is distributed as an [OCI Artifact](https://helm.sh/docs/topics/registries/) as well as via a
traditional [Helm Repository](https://helm.sh/docs/topics/chart_repository/).

* OCI Artifact: `oci://ghcr.io/ceems-dev/charts/kube-ceems`
* Helm Repository: `https://ceems-dev.github.io/helm-charts` with chart `kube-ceems`

The installation instructions use the OCI registry. Refer to the [`helm repo`](https://helm.sh/docs/helm/helm_repo/)
command documentation for information on installing charts via the traditional repository.

### Install Helm Chart

```console
helm install -n ceems --create-namespace ceems oci://ghcr.io/ceems-dev/charts/kube-ceems
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

### Dependencies

By default this chart installs additional, dependent charts:

* [ceems-dev/ceems-exporter](https://github.com/ceems-dev/helm-charts/tree/main/charts/ceems-exporter)
* [ceems-dev/ceems-api-server](https://github.com/ceems-dev/helm-charts/tree/main/charts/ceems-api-server)
* [ceems-dev/ceems-lb](https://github.com/ceems-dev/helm-charts/tree/main/charts/ceems-lb)
* [prometheus-community/kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
* [grafana/pyroscope](https://github.com/grafana/helm-charts/tree/main/charts/grafana)

To disable dependencies during installation, see [multiple releases](#multiple-releases) below.

_See [helm dependency](https://helm.sh/docs/helm/helm_dependency/) for command documentation._

### Uninstall Helm Chart

```console
helm uninstall ceems
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

### Upgrading Chart

```console
helm upgrade -n ceems ceems
```

With Helm v3, CRDs created by this chart's dependencies are not updated by default and should be manually updated.
Consult also the [Helm Documentation on CRDs](https://helm.sh/docs/chart_best_practices/custom_resource_definitions).

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing).
To see all configurable options with detailed comments:

```console
helm show values oci://ghcr.io/ceems-dev/charts/kube-ceems
```

You may also consult chart's [Values](#values) for detailed description of all values.

Values files in the [ci](./ci) folder can be a good starting point for setting up production
deployments with authentication. Each file shows a different scenario with detailed comments
are provided in the files.

## Multiple releases

The same chart can be used to run multiple CEEMS instances in the same cluster if required. This makes sense when one control
plane cluster is managing different workload clusters. To achieve this, it is necessary to run only one instance of Admission Webhook of
CEEMS API server (`ceems-api-server.admissionWebhooks.enabled`) and one instance of prometheus-operator
(`kube-prometheus-stack.prometheusOperator.enabled`) from
[kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack). These two
resources have cluster wide scope and having multiple running instances might have undesired effect.

## Values

<table>
	<thead>
		<th style="width:10px;">Key</th>
		<th>Type</th>
		<th>Default</th>
		<th>Description</th>
	</thead>
	<tbody>
		<tr>
			<td id="global">
              <div style="max-width: 250px;"><a href="./values.yaml#L27">global</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "imagePullSecrets": [],
  "imageRegistry": ""
}
</pre>
</div>
			</td>
			<td>
Global variables  To help compatibility with other charts which use global.imagePullSecrets. Allow either an array of `{name: pullSecret}` maps (k8s-style), or an array of strings (more common helm-style).

```yaml
global:
  imagePullSecrets:
  - name: pullSecret1
  - name: pullSecret2
```
or

```yaml
global:
  imagePullSecrets:
  - pullSecret1
  - pullSecret2
```

</td>
		</tr>
		<tr>
			<td id="global--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L29">global.imagePullSecrets</a></div>
            </td>
            <td>
list or object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Image pull secrets.
</td>
		</tr>
		<tr>
			<td id="global--imageRegistry">
              <div style="max-width: 250px;"><a href="./values.yaml#L31">global.imageRegistry</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Allow parent charts to override registry hostname
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L35">ceemsExporter.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Deploys CEEMS exporter
</td>
		</tr>
		<tr>
			<td id="ceems-exporter--nameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L43">ceems-exporter.nameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Provide a name in place of ceems-exporter for `app:` labels
</td>
		</tr>
		<tr>
			<td id="ceems-exporter--namespaceOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L47">ceems-exporter.namespaceOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Override the deployment namespace
</td>
		</tr>
		<tr>
			<td id="ceems-exporter--fullnameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L51">ceems-exporter.fullnameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Provide a name to substitute for the full names of resources
</td>
		</tr>
		<tr>
			<td id="ceems-exporter--commonLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L55">ceems-exporter.commonLabels</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Labels to apply to all resources (can be templated)
</td>
		</tr>
		<tr>
			<td id="ceems-exporter--image">
              <div style="max-width: 250px;"><a href="./values.yaml#L61">ceems-exporter.image</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "digest": "",
  "pullPolicy": "IfNotPresent",
  "registry": "quay.io",
  "repository": "ceems/ceems",
  "tag": ""
}
</pre>
</div>
			</td>
			<td>
Image details
</td>
		</tr>
		<tr>
			<td id="ceems-exporter--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L65">ceems-exporter.image.tag</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Overrides the image tag whose default is `{{ printf "v%s" .Chart.AppVersion }}`
</td>
		</tr>
		<tr>
			<td id="ceemsAPIServer--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L71">ceemsAPIServer.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Deploys ceems api server
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--nameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L79">ceems-api-server.nameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Provide a name in place of ceems-api-server for `app:` labels
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--namespaceOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L83">ceems-api-server.namespaceOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Override the deployment namespace
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--fullnameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L87">ceems-api-server.fullnameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Provide a name to substitute for the full names of resources
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--commonLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L91">ceems-api-server.commonLabels</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Labels to apply to all resources (can be templated)
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--image">
              <div style="max-width: 250px;"><a href="./values.yaml#L97">ceems-api-server.image</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "digest": "",
  "pullPolicy": "IfNotPresent",
  "registry": "quay.io",
  "repository": "ceems/ceems",
  "tag": ""
}
</pre>
</div>
			</td>
			<td>
Image details
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L101">ceems-api-server.image.tag</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Overrides the image tag whose default is `{{ printf "v%s" .Chart.AppVersion }}`
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--monitoring">
              <div style="max-width: 250px;"><a href="./values.yaml#L107">ceems-api-server.monitoring</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "updaterWebConfig": {
    "web": {
      "url": "https://{{ include \"kube-ceems.kube-prometheus-stack.fullname\" . }}-prometheus.{{ include \"kube-ceems.namespace\" . }}:9090"
    }
  }
}
</pre>
</div>
			</td>
			<td>
Monitoring related configuraton for the current k8s cluster.
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--monitoring--updaterWebConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L111">ceems-api-server.monitoring.updaterWebConfig</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "web": {
    "url": "https://{{ include \"kube-ceems.kube-prometheus-stack.fullname\" . }}-prometheus.{{ include \"kube-ceems.namespace\" . }}:9090"
  }
}
</pre>
</div>
			</td>
			<td>
Web config for TSDB updater, if available. Ref: https://ceems-dev.github.io/ceems/docs/configuration/config-reference#web_client_config
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--grafana--datasource--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L120">ceems-api-server.grafana.datasource.create</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Create a secret to add CEEMS API server as Grafana datasource. This is valid only when `grafana.sidecar.datasources.enabled` is set to <code>true</code>
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--grafana--datasource--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L123">ceems-api-server.grafana.datasource.scheme</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"http"
</pre>
</div>
			</td>
			<td>
Scheme. http or https
</td>
		</tr>
		<tr>
			<td id="ceems-api-server--grafana--datasource--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L136">ceems-api-server.grafana.datasource.basicAuth</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Basic auth username and password to connect to datasource
Example object:

```yaml
basicAuth:
  username: user
  password: supersecret
```

</td>
		</tr>
		<tr>
			<td id="ceems-api-server--grafana--datasource--authHeader">
              <div style="max-width: 250px;"><a href="./values.yaml#L149">ceems-api-server.grafana.datasource.authHeader</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Authentication header name and value to connect to datasource
Example object:

```yaml
authHeader:
  name: Authorization
  value: Bearer token
```

</td>
		</tr>
		<tr>
			<td id="ceems-api-server--grafana--datasource--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L166">ceems-api-server.grafana.datasource.tls</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "authEnabled": false
}
</pre>
</div>
			</td>
			<td>
TLS configuration to connect to datasource
Example object:

```yaml
tls:
  authEnabled: false
  skipVerify: false
  authWithCACert: false
  caCert: <CERTIFICATE CONTENT>
  clientCert: <CERTIFICATE CONTENT>
  clientKey: <CERTIFICATE CONTENT>
```

</td>
		</tr>
		<tr>
			<td id="ceems-api-server--grafana--dashboards--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L172">ceems-api-server.grafana.dashboards.create</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Create a config map to load as Grafana dashboards This is valid only when `grafana.sidecar.dashboards.enabled` is set to <code>true</code>
</td>
		</tr>
		<tr>
			<td id="ceemsLB--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L176">ceemsLB.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Deploys ceems LB
</td>
		</tr>
		<tr>
			<td id="ceems-lb--nameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L184">ceems-lb.nameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Provide a name in place of ceems-lb for `app:` labels
</td>
		</tr>
		<tr>
			<td id="ceems-lb--namespaceOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L188">ceems-lb.namespaceOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Override the deployment namespace
</td>
		</tr>
		<tr>
			<td id="ceems-lb--fullnameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L192">ceems-lb.fullnameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Provide a name to substitute for the full names of resources
</td>
		</tr>
		<tr>
			<td id="ceems-lb--commonLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L196">ceems-lb.commonLabels</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Labels to apply to all resources (can be templated)
</td>
		</tr>
		<tr>
			<td id="ceems-lb--image">
              <div style="max-width: 250px;"><a href="./values.yaml#L202">ceems-lb.image</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "digest": "",
  "pullPolicy": "IfNotPresent",
  "registry": "quay.io",
  "repository": "ceems/ceems",
  "tag": ""
}
</pre>
</div>
			</td>
			<td>
Image details
</td>
		</tr>
		<tr>
			<td id="ceems-lb--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L206">ceems-lb.image.tag</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Overrides the image tag whose default is `{{ printf "v%s" .Chart.AppVersion }}`
</td>
		</tr>
		<tr>
			<td id="ceems-lb--grafana--datasource--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L215">ceems-lb.grafana.datasource.create</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Create a secret to add CEEMS LB as Grafana datasource. This is valid only when `grafana.sidecar.datasources.enabled` is set to <code>true</code>
</td>
		</tr>
		<tr>
			<td id="ceems-lb--grafana--datasource--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L218">ceems-lb.grafana.datasource.scheme</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"http"
</pre>
</div>
			</td>
			<td>
Scheme. http or https
</td>
		</tr>
		<tr>
			<td id="ceems-lb--grafana--datasource--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L232">ceems-lb.grafana.datasource.basicAuth</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Basic auth username and password to connect to datasource

Example object:

```yaml
basicAuth:
  username: user
  password: supersecret
```

</td>
		</tr>
		<tr>
			<td id="ceems-lb--grafana--datasource--authHeader">
              <div style="max-width: 250px;"><a href="./values.yaml#L246">ceems-lb.grafana.datasource.authHeader</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Authentication header name and value to connect to datasource

Example object:

```yaml
authHeader:
  name: Authorization
  value: Bearer token
```

</td>
		</tr>
		<tr>
			<td id="ceems-lb--grafana--datasource--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L264">ceems-lb.grafana.datasource.tls</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "authEnabled": false
}
</pre>
</div>
			</td>
			<td>
TLS configuration to connect to datasource

Example object:

```yaml
tls:
  authEnabled: false
  skipVerify: false
  authWithCACert: false
  caCert: <CERTIFICATE CONTENT>
  clientCert: <CERTIFICATE CONTENT>
  clientKey: <CERTIFICATE CONTENT>
```

</td>
		</tr>
		<tr>
			<td id="kubePrometheusStack--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L269">kubePrometheusStack.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Deploys kube-prometheus-stack
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--fullnameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L281">kube-prometheus-stack.fullnameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
If this is not empty, configs for CEEMS API server and CEEMS LB must be manually provided as service URLs are used based on default fullname of the chart.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--crds">
              <div style="max-width: 250px;"><a href="./values.yaml#L286">kube-prometheus-stack.crds</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": true
}
</pre>
</div>
			</td>
			<td>
Install Prometheus Operator CRDs. Set it to true if CRDs are not already installed #
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--defaultRules">
              <div style="max-width: 250px;"><a href="./values.yaml#L293">kube-prometheus-stack.defaultRules</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "create": false
}
</pre>
</div>
			</td>
			<td>
Do not create default rules for monitoring the cluster as this Prometheus instance is not meant to monitor system metrics of cluster.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--prometheusOperator--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L300">kube-prometheus-stack.prometheusOperator.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Enable prometheus operator
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--prometheusOperator--namespaces">
              <div style="max-width: 250px;"><a href="./values.yaml#L305">kube-prometheus-stack.prometheusOperator.namespaces</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "releaseNamespace": true
}
</pre>
</div>
			</td>
			<td>
Namespaces to scope the interaction of the Prometheus Operator and the apiserver (allow list). This is mutually exclusive with denyNamespaces. Setting this to an empty object will disable the configuration
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--prometheusOperator--kubeletService--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L312">kube-prometheus-stack.prometheusOperator.kubeletService.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
false
</pre>
</div>
			</td>
			<td>
If true, the operator will create and maintain a service for scraping kubelets Ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/helm/prometheus-operator/README.md
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--prometheusOperator--kubeletEndpointsEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L316">kube-prometheus-stack.prometheusOperator.kubeletEndpointsEnabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
false
</pre>
</div>
			</td>
			<td>
Do not create Endpoints objects for kubelet targets.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--prometheusOperator--kubeletEndpointSliceEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L319">kube-prometheus-stack.prometheusOperator.kubeletEndpointSliceEnabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
false
</pre>
</div>
			</td>
			<td>
Do not create EndpointSlice objects for kubelet targets.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--prometheus">
              <div style="max-width: 250px;"><a href="./values.yaml#L323">kube-prometheus-stack.prometheus</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": true
}
</pre>
</div>
			</td>
			<td>
Deploy a Prometheus instance
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L329">kube-prometheus-stack.grafana.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L334">kube-prometheus-stack.grafana.env</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "GF_DATAPROXY_SEND_USER_HEADER": true
}
</pre>
</div>
			</td>
			<td>
Necessary configuration as env vars. User header is necessary for proper functionning of CEEMS API server and CEEMS LB datasources.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--defaultDashboardsEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L339">kube-prometheus-stack.grafana.defaultDashboardsEnabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
false
</pre>
</div>
			</td>
			<td>
Do not deploy default dashboards
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--adminUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L342">kube-prometheus-stack.grafana.adminUser</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"admin"
</pre>
</div>
			</td>
			<td>
Admin username
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--adminPassword">
              <div style="max-width: 250px;"><a href="./values.yaml#L345">kube-prometheus-stack.grafana.adminPassword</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"kube-ceems"
</pre>
</div>
			</td>
			<td>
Admin user password. Use a secure password for production instances
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--plugins">
              <div style="max-width: 250px;"><a href="./values.yaml#L349">kube-prometheus-stack.grafana.plugins</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[
  "yesoreyeram-infinity-datasource"
]
</pre>
</div>
			</td>
			<td>
Plugins to install. Infinity datasource is needed for CEEMS API server.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L353">kube-prometheus-stack.grafana.serviceAccount.create</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L358">kube-prometheus-stack.grafana.sidecar.datasources.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Enable datasources sidecar.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--defaultDatasourceEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L360">kube-prometheus-stack.grafana.sidecar.datasources.defaultDatasourceEnabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Create default Prometheus datasource.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--label">
              <div style="max-width: 250px;"><a href="./values.yaml#L362">kube-prometheus-stack.grafana.sidecar.datasources.label</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"kube-ceems-grafana-datasource"
</pre>
</div>
			</td>
			<td>
Label that the configmaps with datasources are marked with (can be templated)
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--labelValue">
              <div style="max-width: 250px;"><a href="./values.yaml#L364">kube-prometheus-stack.grafana.sidecar.datasources.labelValue</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"enable"
</pre>
</div>
			</td>
			<td>
Value of label that the configmaps with datasources are set to (can be templated)
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--searchNamespace">
              <div style="max-width: 250px;"><a href="./values.yaml#L366">kube-prometheus-stack.grafana.sidecar.datasources.searchNamespace</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Search for datasources only in current namespace.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L368">kube-prometheus-stack.grafana.sidecar.datasources.name</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"CEEMS-Prometheus"
</pre>
</div>
			</td>
			<td>
Default datasource name
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L375">kube-prometheus-stack.grafana.sidecar.datasources.env</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Environment variables for sidecar container. If `certificate verify failed` errors are seen in the sidecar logs, it means sidecar container is unable to verify Kubernetes API server's CA certificate. More details can be found in this <a target="_blank" href="https://github.com/kiwigrid/k8s-sidecar/issues/400">GitHub Issue</a>. To circumvent the problem, use `SKIP_TLS_VERIFY: true`. However, note that this is not a formidable solution for production deployments.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--datasources--alertmanager">
              <div style="max-width: 250px;"><a href="./values.yaml#L378">kube-prometheus-stack.grafana.sidecar.datasources.alertmanager</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable alert manager
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L382">kube-prometheus-stack.grafana.sidecar.dashboards.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Enable dashboards sidecar.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--label">
              <div style="max-width: 250px;"><a href="./values.yaml#L384">kube-prometheus-stack.grafana.sidecar.dashboards.label</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"kube-ceems-grafana-dashboard"
</pre>
</div>
			</td>
			<td>
Label that the configmaps with dashboards are marked with (can be templated)
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--labelValue">
              <div style="max-width: 250px;"><a href="./values.yaml#L386">kube-prometheus-stack.grafana.sidecar.dashboards.labelValue</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"enable"
</pre>
</div>
			</td>
			<td>
Value of label that the configmaps with dashboards are set to (can be templated)
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--searchNamespace">
              <div style="max-width: 250px;"><a href="./values.yaml#L388">kube-prometheus-stack.grafana.sidecar.dashboards.searchNamespace</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
Search for dashboards only in current namespace.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--folderAnnotation">
              <div style="max-width: 250px;"><a href="./values.yaml#L390">kube-prometheus-stack.grafana.sidecar.dashboards.folderAnnotation</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"kube-ceems-grafana-dashboard-folder"
</pre>
</div>
			</td>
			<td>
Annotation to set the name of the folder
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--provider">
              <div style="max-width: 250px;"><a href="./values.yaml#L393">kube-prometheus-stack.grafana.sidecar.dashboards.provider</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "foldersFromFilesStructure": true,
  "name": "ceemsSidecarProvider",
  "updateIntervalSeconds": 600
}
</pre>
</div>
			</td>
			<td>
Dashboard provider config
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--provider--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L395">kube-prometheus-stack.grafana.sidecar.dashboards.provider.name</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ceemsSidecarProvider"
</pre>
</div>
			</td>
			<td>
name of the provider, should be unique
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--provider--updateIntervalSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L397">kube-prometheus-stack.grafana.sidecar.dashboards.provider.updateIntervalSeconds</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
600
</pre>
</div>
			</td>
			<td>
Interval at which to check for dashboard updates
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--provider--foldersFromFilesStructure">
              <div style="max-width: 250px;"><a href="./values.yaml#L399">kube-prometheus-stack.grafana.sidecar.dashboards.provider.foldersFromFilesStructure</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
true
</pre>
</div>
			</td>
			<td>
Allow Grafana to replicate dashboard structure from filesystem
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--sidecar--dashboards--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L407">kube-prometheus-stack.grafana.sidecar.dashboards.env</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{}
</pre>
</div>
			</td>
			<td>
Environment variables for sidecar container. If `certificate verify failed` errors are seen in the sidecar logs, it means sidecar container is unable to verify Kubernetes API server's CA certificate. More details can be found in this <a target="_blank" href="https://github.com/kiwigrid/k8s-sidecar/issues/400">GitHub Issue</a>. To circumvent the problem, use `SKIP_TLS_VERIFY: true`. However, note that this is not a formidable solution for production deployments.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--grafana--serviceMonitor--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L413">kube-prometheus-stack.grafana.serviceMonitor.enabled</a></div>
            </td>
            <td>
bool
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
false
</pre>
</div>
			</td>
			<td>
If true, a <code>ServiceMonitor</code> CRD is created for a prometheus operator Ref: https://github.com/prometheus-operator/prometheus-operator
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--extraManifests">
              <div style="max-width: 250px;"><a href="./values.yaml#L418">kube-prometheus-stack.extraManifests</a></div>
            </td>
            <td>
dict or list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
null
</pre>
</div>
			</td>
			<td>
Extra manifests to deploy.  Can be of type dict or list. If dict, keys are ignored and only values are used. Items contained within extraObjects can be defined as dict or string and are passed through tpl.
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--thanosRuler">
              <div style="max-width: 250px;"><a href="./values.yaml#L445">kube-prometheus-stack.thanosRuler</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable thanosRuler Ref: https://thanos.io/tip/components/rule.md/
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--alertmanager">
              <div style="max-width: 250px;"><a href="./values.yaml#L451">kube-prometheus-stack.alertmanager</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable alertmanager Ref: https://prometheus.io/docs/alerting/alertmanager/
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubernetesServiceMonitors">
              <div style="max-width: 250px;"><a href="./values.yaml#L456">kube-prometheus-stack.kubernetesServiceMonitors</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Flag to disable all the kubernetes component scrapers
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubeApiServer">
              <div style="max-width: 250px;"><a href="./values.yaml#L461">kube-prometheus-stack.kubeApiServer</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping the kube api server
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubelet">
              <div style="max-width: 250px;"><a href="./values.yaml#L466">kube-prometheus-stack.kubelet</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping the kubelet and kubelet-hosted cAdvisor
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubeControllerManager">
              <div style="max-width: 250px;"><a href="./values.yaml#L471">kube-prometheus-stack.kubeControllerManager</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping the kube controller manager
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--coreDns">
              <div style="max-width: 250px;"><a href="./values.yaml#L476">kube-prometheus-stack.coreDns</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping coreDns. Use either this or kubeDns
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubeDns">
              <div style="max-width: 250px;"><a href="./values.yaml#L481">kube-prometheus-stack.kubeDns</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping kubeDns. Use either this or coreDns
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubeEtcd">
              <div style="max-width: 250px;"><a href="./values.yaml#L486">kube-prometheus-stack.kubeEtcd</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping etcd
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubeScheduler">
              <div style="max-width: 250px;"><a href="./values.yaml#L491">kube-prometheus-stack.kubeScheduler</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping kube scheduler
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubeProxy">
              <div style="max-width: 250px;"><a href="./values.yaml#L496">kube-prometheus-stack.kubeProxy</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping kube proxy
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--kubeStateMetrics">
              <div style="max-width: 250px;"><a href="./values.yaml#L501">kube-prometheus-stack.kubeStateMetrics</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable component scraping kube state metrics
</td>
		</tr>
		<tr>
			<td id="kube-prometheus-stack--nodeExporter">
              <div style="max-width: 250px;"><a href="./values.yaml#L506">kube-prometheus-stack.nodeExporter</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable deploying node exporter as a daemonset to all nodes
</td>
		</tr>
		<tr>
			<td id="pyroscopeServer">
              <div style="max-width: 250px;"><a href="./values.yaml#L510">pyroscopeServer</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Enable deploying Grafana Pyroscope server.
</td>
		</tr>
		<tr>
			<td id="pyroscope--pyroscope--fullnameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L519">pyroscope.pyroscope.fullnameOverride</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
""
</pre>
</div>
			</td>
			<td>
If this is not empty, configs for CEEMS exporter and CEEMS LB must be manually provided as service URLs are used based on default fullname of the chart.
</td>
		</tr>
		<tr>
			<td id="pyroscope--ingress">
              <div style="max-width: 250px;"><a href="./values.yaml#L522">pyroscope.ingress</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable ingress
</td>
		</tr>
		<tr>
			<td id="pyroscope--alloy">
              <div style="max-width: 250px;"><a href="./values.yaml#L526">pyroscope.alloy</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable alloy
</td>
		</tr>
		<tr>
			<td id="pyroscope--agent">
              <div style="max-width: 250px;"><a href="./values.yaml#L530">pyroscope.agent</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable alloy agent
</td>
		</tr>
		<tr>
			<td id="pyroscope--minio">
              <div style="max-width: 250px;"><a href="./values.yaml#L534">pyroscope.minio</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false
}
</pre>
</div>
			</td>
			<td>
Disable minio
</td>
		</tr>
	</tbody>
</table>

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

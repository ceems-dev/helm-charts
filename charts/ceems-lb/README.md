<!-- textlint-disable -->

# ceems-lb

![Version: 0.2.1](https://img.shields.io/badge/Version-0.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.12.1](https://img.shields.io/badge/AppVersion-0.12.1-informational?style=flat-square)

A Helm chart for deploying CEEMS LB

**Homepage:** <https://ceems-dev.github.io/helm-charts/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mahendrapaipuri | <mahendra.paipuri@gmail.com> | <https://github.com/mahendrapaipuri> |

## Source Code

* <https://github.com/ceems-dev/helm-charts>

<!-- textlint-enable -->

## Description

Installs LB component of the [CEEMS](https://ceems-dev.github.io/ceems/docs/),
that imposes access control on TSDB and Pyroscope datasources in Grafana in a multi-tenant
environment.

## Prerequisites

* Kubernetes 1.19+
* Helm 3+

## Usage

The chart is distributed as an [OCI Artifact](https://helm.sh/docs/topics/registries/) as well as via a
traditional [Helm Repository](https://helm.sh/docs/topics/chart_repository/).

* OCI Artifact: `oci://ghcr.io/ceems-dev/charts/ceems-lb`
* Helm Repository: `https://ceems-dev.github.io/helm-charts` with chart `ceems-lb`

The installation instructions use the OCI registry. Refer to the [`helm repo`](https://helm.sh/docs/helm/helm_repo/)
command documentation for information on installing charts via the traditional repository.

### Install Helm Chart

```console
helm install -n ceems --create-namespace ceems-lb oci://ghcr.io/ceems-dev/charts/ceems-lb
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

### Uninstall Helm Chart

```console
helm uninstall -n ceems ceems-lb
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

### Upgrading Chart

```console
helm upgrade -n ceems ceems-lb
```

With Helm v3, CRDs created by this chart's dependencies are not updated by default and should be manually updated.
Consult also the [Helm Documentation on CRDs](https://helm.sh/docs/chart_best_practices/custom_resource_definitions).

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing).
To see all configurable options with detailed comments:

```console
helm show values oci://ghcr.io/ceems-dev/charts/ceems-lb
```

You may also consult chart's [Values](#values) for detailed description of all values.

Values files in the [ci](./ci) folder can be a good starting point for setting up production
deployments with authentication. Each file shows a different scenario with detailed comments
are provided in the files.

## Multiple releases

The same chart can be used to run multiple CEEMS instances in the same cluster if required.

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
			<td id="nameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L7">nameOverride</a></div>
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
			<td id="namespaceOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L11">namespaceOverride</a></div>
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
			<td id="fullnameOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L15">fullnameOverride</a></div>
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
			<td id="commonLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L19">commonLabels</a></div>
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
			<td id="image">
              <div style="max-width: 250px;"><a href="./values.yaml#L25">image</a></div>
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
			<td id="image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L29">image.tag</a></div>
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
			<td id="global">
              <div style="max-width: 250px;"><a href="./values.yaml#L55">global</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L57">global.imagePullSecrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L59">global.imageRegistry</a></div>
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
			<td id="imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L62">imagePullSecrets</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="revisionHistoryLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L67">revisionHistoryLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
10
</pre>
</div>
			</td>
			<td>
Number of old history to retain to allow rollback Default Kubernetes value is set to 10
</td>
		</tr>
		<tr>
			<td id="rbac--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L72">rbac.create</a></div>
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
Create RBAC resources
</td>
		</tr>
		<tr>
			<td id="rbac--extraClusterRoleRules">
              <div style="max-width: 250px;"><a href="./values.yaml#L74">rbac.extraClusterRoleRules</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Any extra cluster roles to be added to CEEMS exporter.
</td>
		</tr>
		<tr>
			<td id="config">
              <div style="max-width: 250px;"><a href="./values.yaml#L82">config</a></div>
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
CEEMS LB config Ref: https://ceems-dev.github.io/ceems/docs/configuration/config-reference#ceems_lb
</td>
		</tr>
		<tr>
			<td id="ceemsAPIServer">
              <div style="max-width: 250px;"><a href="./values.yaml#L87">ceemsAPIServer</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "persistenceVolumeClaim": "",
  "web": {}
}
</pre>
</div>
			</td>
			<td>
CEEMS API server related configuration needed for CEEMS LB for imposing access control on Prometheus data.
</td>
		</tr>
		<tr>
			<td id="ceemsAPIServer--persistenceVolumeClaim">
              <div style="max-width: 250px;"><a href="./values.yaml#L93">ceemsAPIServer.persistenceVolumeClaim</a></div>
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
PVC for CEEMS API server's storage. For best performance mount the volume that contains CEEMS DB. Provide the persistence volume claim used by the CEEMS API server and PV containing CEEMS DB will be mounted into the CEEMS LB container. Can be templated.
</td>
		</tr>
		<tr>
			<td id="ceemsAPIServer--web">
              <div style="max-width: 250px;"><a href="./values.yaml#L99">ceemsAPIServer.web</a></div>
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
HTTP client configuration for CEEMS API server. If provided, access control will be done by sending HTTP requests to CEEMS API server. This is LESS EFFICIENT than mounting the PV containing CEEMS DB directly.
</td>
		</tr>
		<tr>
			<td id="webConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L103">webConfig</a></div>
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
CEEMS LB web config Ref: https://ceems-dev.github.io/ceems/docs/configuration/basic-auth#reference
</td>
		</tr>
		<tr>
			<td id="additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L118">additionalArgs</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Additional arguments for CEEMS LB List of dicts with <code>name</code> and <code>value</code> fields. <code>value</code> field can be empty for name only arguments. For e.g., for `--log.level=debug` set the following

```yaml
additionalArgs:
  - name: log.level
    value: debug
```

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L127">kubeRBACProxy.enabled</a></div>
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
When enabled, creates a kube-rbac-proxy to protect the CEEMS LB and CEEMS LB http endpoint. The requests are served through the same service but requests are HTTPS.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L129">kubeRBACProxy.env</a></div>
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
Set environment variables as name/value pairs for kube-rbac-proxy.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L133">kubeRBACProxy.image.registry</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"quay.io"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--image--repository">
              <div style="max-width: 250px;"><a href="./values.yaml#L134">kubeRBACProxy.image.repository</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"brancz/kube-rbac-proxy"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L135">kubeRBACProxy.image.tag</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"v0.20.2"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L136">kubeRBACProxy.image.sha</a></div>
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

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--image--pullPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L137">kubeRBACProxy.image.pullPolicy</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"IfNotPresent"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L154">kubeRBACProxy.additionalArgs</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
List of additional CLI arguments to configure kube-rbac-proxy for example: `--tls-cipher-suites`, `--log-file`, etc. All the possible args can be found here: https://github.com/brancz/kube-rbac-proxy#usage  Arguments must be passed as list of dicts with <code>name</code> and <code>value</code> as fields of dict. <code>value</code> can be optional for name only arguments.

```yaml
additionalArgs:
  - name: log-file
    value: /path/to/log/file
```

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--containerSecurityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L159">kubeRBACProxy.containerSecurityContext</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "privileged": false,
  "readOnlyRootFilesystem": true
}
</pre>
</div>
			</td>
			<td>
Specify security settings for a Container Allows overrides and additional options compared to (Pod) securityContext Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L164">kubeRBACProxy.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
8030
</pre>
</div>
			</td>
			<td>
Specify the port used for the ceems lb container (upstream port)
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L166">kubeRBACProxy.portName</a></div>
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
Specify the name of the container port
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--enableHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L168">kubeRBACProxy.enableHostPort</a></div>
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
Configure a <code>hostPort</code>. If true, <code>hostPort</code> will be enabled in the container and set to service.port.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--proxyEndpointsPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L172">kubeRBACProxy.proxyEndpointsPort</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
8888
</pre>
</div>
			</td>
			<td>
Configure Proxy Endpoints Port This is the port being probed for readiness
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--enableProxyEndpointsHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L174">kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
Configure a <code>hostPort</code>. If true, <code>hostPort</code> will be enabled in the container and set to <code>proxyEndpointsPort</code>.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L179">kubeRBACProxy.resources</a></div>
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
We usually recommend not to specify default resources and to leave this as a conscious choice for the user. This also increases chances charts run on environments with little resources, such as Minikube.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L190">kubeRBACProxy.extraVolumeMounts</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Additional volume mounts in the kube-rbac-proxy container
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L198">kubeRBACProxy.tls</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false,
  "tlsClientAuth": false
}
</pre>
</div>
			</td>
			<td>
Enables using TLS resources from a volume on secret referred to in <code>tlsSecret</code>. When enabling <code>tlsClientAuth</code>, client CA certificate must be set in `tlsSecret.caItem`. Ref. https://github.com/brancz/kube-rbac-proxy/issues/187
</td>
		</tr>
		<tr>
			<td id="tlsSecret--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L207">tlsSecret.enabled</a></div>
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
<code>tlsSecret</code> refers to an existing secret holding TLS items: client CA certificate, private key and certificate. <code>secretName</code> and <code>volumeName</code> can be templated. If enabled, volume <code>volumeName</code> gets created on secret <code>secretName</code>. The volume's resources will be used by kube-rbac-proxy if `kubeRBACProxy.tls.enabled` is set.
</td>
		</tr>
		<tr>
			<td id="tlsSecret--caItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L209">tlsSecret.caItem</a></div>
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
Key with client CA certificate (optional)
</td>
		</tr>
		<tr>
			<td id="tlsSecret--certItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L211">tlsSecret.certItem</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"tls.crt"
</pre>
</div>
			</td>
			<td>
Key with certificate
</td>
		</tr>
		<tr>
			<td id="tlsSecret--keyItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L213">tlsSecret.keyItem</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"tls.key"
</pre>
</div>
			</td>
			<td>
Key with private key
</td>
		</tr>
		<tr>
			<td id="tlsSecret--secretName">
              <div style="max-width: 250px;"><a href="./values.yaml#L215">tlsSecret.secretName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ceems-lb-tls"
</pre>
</div>
			</td>
			<td>
Name of an existing secret
</td>
		</tr>
		<tr>
			<td id="tlsSecret--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L217">tlsSecret.volumeName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ceems-lb-tls"
</pre>
</div>
			</td>
			<td>
Name of the volume to be created
</td>
		</tr>
		<tr>
			<td id="service--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L228">service.enabled</a></div>
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
Creating a service is enabled by default  If both TSDB and Pyroscope backends are enabled for CEEMS LB, the TSDB servers can be reached at configured port number (default 9030) and Pyroscope servers can be reached at configured port number plus 10. That means if configured port is 9030, TSDB is available at 9030 and Pyroscope is available at 9040. Consequently the port names will have `-tsdb` and `-pyroscope` suffices.
</td>
		</tr>
		<tr>
			<td id="service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L231">service.type</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ClusterIP"
</pre>
</div>
			</td>
			<td>
Service type
</td>
		</tr>
		<tr>
			<td id="service--clusterIP">
              <div style="max-width: 250px;"><a href="./values.yaml#L233">service.clusterIP</a></div>
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
IP address for type <code>ClusterIP</code>
</td>
		</tr>
		<tr>
			<td id="service--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L236">service.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
9030
</pre>
</div>
			</td>
			<td>
Default service port. Sets the port of the exposed container as well (NE or kubeRBACProxy). Use <code>servicePort</code> below if changing the service port only is desired.
</td>
		</tr>
		<tr>
			<td id="service--servicePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L239">service.servicePort</a></div>
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
Service port. Use this field if you wish to set a different service port without changing the container port (<code>port</code> above).
</td>
		</tr>
		<tr>
			<td id="service--targetPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L241">service.targetPort</a></div>
            </td>
            <td>
int or string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
9030
</pre>
</div>
			</td>
			<td>
Targeted port in the pod. Must refer to an open container port (<code>port</code> or <code>portName</code>).
</td>
		</tr>
		<tr>
			<td id="service--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L243">service.portName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"endpoint"
</pre>
</div>
			</td>
			<td>
Name of the service port. Sets the port name of the main container (NE) as well.
</td>
		</tr>
		<tr>
			<td id="service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L245">service.nodePort</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
null
</pre>
</div>
			</td>
			<td>
Port number for service type <code>NodePort</code>
</td>
		</tr>
		<tr>
			<td id="service--listenOnAllInterfaces">
              <div style="max-width: 250px;"><a href="./values.yaml#L248">service.listenOnAllInterfaces</a></div>
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
If true, CEEMS LB will listen on all interfaces
</td>
		</tr>
		<tr>
			<td id="service--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L251">service.annotations</a></div>
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
Additional annotations and labels for the service
</td>
		</tr>
		<tr>
			<td id="service--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L252">service.labels</a></div>
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

</td>
		</tr>
		<tr>
			<td id="service--ipDualStack">
              <div style="max-width: 250px;"><a href="./values.yaml#L256">service.ipDualStack</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false,
  "ipFamilies": [
    "IPv6",
    "IPv4"
  ],
  "ipFamilyPolicy": "PreferDualStack"
}
</pre>
</div>
			</td>
			<td>
Dual stack settings for the service Ref: https://kubernetes.io/docs/concepts/services-networking/dual-stack/#services
</td>
		</tr>
		<tr>
			<td id="service--externalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L263">service.externalTrafficPolicy</a></div>
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
External traffic policy setting (Cluster, Local) https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies
</td>
		</tr>
		<tr>
			<td id="service--internalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L266">service.internalTrafficPolicy</a></div>
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
Internal traffic policy setting (Cluster, Local) https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies
</td>
		</tr>
		<tr>
			<td id="networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L270">networkPolicy</a></div>
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
Set a NetworkPolicy with: ingress only on service.port or custom policy
</td>
		</tr>
		<tr>
			<td id="env">
              <div style="max-width: 250px;"><a href="./values.yaml#L280">env</a></div>
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
Additional environment variables that will be passed to the deployment
</td>
		</tr>
		<tr>
			<td id="updateStrategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L285">updateStrategy</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "rollingUpdate": {
    "maxUnavailable": 1
  },
  "type": "RollingUpdate"
}
</pre>
</div>
			</td>
			<td>
Customize the <code>updateStrategy</code> if set
</td>
		</tr>
		<tr>
			<td id="resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L293">resources</a></div>
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
We usually recommend not to specify default resources and to leave this as a conscious choice for the user. This also increases chances charts run on environments with little resources, such as Minikube.
</td>
		</tr>
		<tr>
			<td id="restartPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L305">restartPolicy</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
null
</pre>
</div>
			</td>
			<td>
Specify the container restart policy passed to the CEEMS Exporter container Possible Values: `Always|OnFailure|Never`. Default value is <code>Always</code>.
</td>
		</tr>
		<tr>
			<td id="serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L309">serviceAccount.create</a></div>
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
Specifies whether a <code>ServiceAccount</code> should be created
</td>
		</tr>
		<tr>
			<td id="serviceAccount--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L312">serviceAccount.name</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
null
</pre>
</div>
			</td>
			<td>
The name of the <code>ServiceAccount</code> to use. If not set and create is true, a name is generated using the fullname template
</td>
		</tr>
		<tr>
			<td id="serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L313">serviceAccount.annotations</a></div>
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

</td>
		</tr>
		<tr>
			<td id="serviceAccount--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L314">serviceAccount.imagePullSecrets</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="serviceAccount--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L315">serviceAccount.automountServiceAccountToken</a></div>
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

</td>
		</tr>
		<tr>
			<td id="securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L318">securityContext.runAsGroup</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
65534
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L319">securityContext.runAsNonRoot</a></div>
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
			<td id="securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L320">securityContext.runAsUser</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
65534
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="containerSecurityContext--privileged">
              <div style="max-width: 250px;"><a href="./values.yaml#L323">containerSecurityContext.privileged</a></div>
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

</td>
		</tr>
		<tr>
			<td id="containerSecurityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L324">containerSecurityContext.readOnlyRootFilesystem</a></div>
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
			<td id="containerSecurityContext--allowPrivilegeEscalation">
              <div style="max-width: 250px;"><a href="./values.yaml#L325">containerSecurityContext.allowPrivilegeEscalation</a></div>
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

</td>
		</tr>
		<tr>
			<td id="hostNetwork">
              <div style="max-width: 250px;"><a href="./values.yaml#L331">hostNetwork</a></div>
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
Expose the service to the host network
</td>
		</tr>
		<tr>
			<td id="hostPID">
              <div style="max-width: 250px;"><a href="./values.yaml#L334">hostPID</a></div>
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
Share the host process ID namespace
</td>
		</tr>
		<tr>
			<td id="hostIPC">
              <div style="max-width: 250px;"><a href="./values.yaml#L337">hostIPC</a></div>
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
Share the host IPC namespace
</td>
		</tr>
		<tr>
			<td id="affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L341">affinity</a></div>
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
Assign a group of affinity scheduling rules
</td>
		</tr>
		<tr>
			<td id="podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L352">podAnnotations</a></div>
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
Annotations to be added to pods
</td>
		</tr>
		<tr>
			<td id="podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L355">podLabels</a></div>
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
Extra labels to add to pods (can be templated)
</td>
		</tr>
		<tr>
			<td id="deployAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L358">deployAnnotations</a></div>
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
Annotations to be added to deployment
</td>
		</tr>
		<tr>
			<td id="dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L361">dnsConfig</a></div>
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
Custom DNS configuration to be added to pods
</td>
		</tr>
		<tr>
			<td id="nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L374">nodeSelector</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "kubernetes.io/os": "linux"
}
</pre>
</div>
			</td>
			<td>
Assign a <code>nodeSelector</code> if operating a hybrid cluster
</td>
		</tr>
		<tr>
			<td id="terminationGracePeriodSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L379">terminationGracePeriodSeconds</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
null
</pre>
</div>
			</td>
			<td>
Specify grace period for graceful termination of pods. Defaults to 30 if null or not specified
</td>
		</tr>
		<tr>
			<td id="tolerations[0]--effect">
              <div style="max-width: 250px;"><a href="./values.yaml#L382">tolerations[0].effect</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"NoSchedule"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="tolerations[0]--operator">
              <div style="max-width: 250px;"><a href="./values.yaml#L383">tolerations[0].operator</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"Exists"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="terminationMessageParams">
              <div style="max-width: 250px;"><a href="./values.yaml#L387">terminationMessageParams</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false,
  "terminationMessagePath": "/dev/termination-log",
  "terminationMessagePolicy": "File"
}
</pre>
</div>
			</td>
			<td>
Enable or disable container termination message settings Ref: https://kubernetes.io/docs/tasks/debug/debug-application/determine-reason-pod-failure/
</td>
		</tr>
		<tr>
			<td id="priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L395">priorityClassName</a></div>
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
Assign a <code>PriorityClassName</code> to pods if set
</td>
		</tr>
		<tr>
			<td id="extraHostVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L399">extraHostVolumeMounts</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Additional mounts from the host to CEEMS LB container
</td>
		</tr>
		<tr>
			<td id="configmaps">
              <div style="max-width: 250px;"><a href="./values.yaml#L410">configmaps</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Additional configmaps to be mounted.
</td>
		</tr>
		<tr>
			<td id="secrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L416">secrets</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Additional secrets to be mounted.
</td>
		</tr>
		<tr>
			<td id="extraInitContainers">
              <div style="max-width: 250px;"><a href="./values.yaml#L422">extraInitContainers</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Additional InitContainers to initialize the pod
</td>
		</tr>
		<tr>
			<td id="extraManifests">
              <div style="max-width: 250px;"><a href="./values.yaml#L425">extraManifests</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Extra manifests to deploy as an array
</td>
		</tr>
		<tr>
			<td id="extraVolumes">
              <div style="max-width: 250px;"><a href="./values.yaml#L435">extraVolumes</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Extra volumes to become available in the pod
</td>
		</tr>
		<tr>
			<td id="extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L443">extraVolumeMounts</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[]
</pre>
</div>
			</td>
			<td>
Extra volume mounts in the CEEMS LB container
</td>
		</tr>
		<tr>
			<td id="livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L450">livenessProbe</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "failureThreshold": 3,
  "initialDelaySeconds": 0,
  "periodSeconds": 10,
  "successThreshold": 1,
  "timeoutSeconds": 1
}
</pre>
</div>
			</td>
			<td>
Liveness probe
</td>
		</tr>
		<tr>
			<td id="readinessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L459">readinessProbe</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "failureThreshold": 3,
  "initialDelaySeconds": 0,
  "periodSeconds": 10,
  "successThreshold": 1,
  "timeoutSeconds": 1
}
</pre>
</div>
			</td>
			<td>
Readiness probe
</td>
		</tr>
		<tr>
			<td id="version">
              <div style="max-width: 250px;"><a href="./values.yaml#L467">version</a></div>
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
Override version of app, required if image.tag is defined and does not follow semver
</td>
		</tr>
	</tbody>
</table>

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

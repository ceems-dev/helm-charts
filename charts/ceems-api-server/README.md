<!-- textlint-disable -->

# ceems-api-server

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.12.1](https://img.shields.io/badge/AppVersion-0.12.1-informational?style=flat-square)

A Helm chart for deploying CEEMS API server

**Homepage:** <https://ceems-dev.github.io/helm-charts/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mahendrapaipuri | <mahendra.paipuri@gmail.com> | <https://github.com/mahendrapaipuri> |

## Source Code

* <https://github.com/ceems-dev/helm-charts>

<!-- textlint-enable -->

## Description

Installs API server component of the [CEEMS](https://ceems-dev.github.io/ceems/docs/),
that fetches metadata of pods in a k8s cluster to estimate the energy and emissions usage
of workloads.

## Prerequisites

* Kubernetes 1.19+
* Helm 3+

## Usage

The chart is distributed as an [OCI Artifact](https://helm.sh/docs/topics/registries/) as well as via a
traditional [Helm Repository](https://helm.sh/docs/topics/chart_repository/).

* OCI Artifact: `oci://ghcr.io/ceems-dev/charts/ceems-api-server`
* Helm Repository: `https://ceems-dev.github.io/helm-charts` with chart `ceems-api-server`

The installation instructions use the OCI registry. Refer to the [`helm repo`](https://helm.sh/docs/helm/helm_repo/)
command documentation for information on installing charts via the traditional repository.

### Install Helm Chart

```console
helm install -n ceems --create-namespace ceems-api-server oci://ghcr.io/ceems-dev/charts/ceems-api-server
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

### Uninstall Helm Chart

```console
helm uninstall -n ceems ceems-api-server
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

### Upgrading Chart

```console
helm upgrade -n ceems ceems-api-server
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing).
To see all configurable options with detailed comments:

```console
helm show values oci://ghcr.io/ceems-dev/charts/ceems-api-server
```

You may also consult chart's [Values](#values) for detailed description of all values.

Values files in the [ci](./ci) folder can be a good starting point for setting up production
deployments with authentication. Each file shows a different scenario with detailed comments
are provided in the files.

## Multiple releases

The same chart can be used to run multiple CEEMS instances in the same cluster if required. This makes sense when one control
plane cluster is managing different workload clusters. To achieve this, it is necessary to run only one instance of Admission Webhook of
CEEMS API server (`ceemsAPIServer.admissionWebhooks.enabled`). This
resource has cluster wide scope and having multiple running instances might have undesired effect.

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
Provide a name in place of ceems-api-server for `app:` labels
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
			<td id="monitoring">
              <div style="max-width: 250px;"><a href="./values.yaml#L63">monitoring</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "clusterID": "",
  "enabled": true,
  "updaterWebConfig": {}
}
</pre>
</div>
			</td>
			<td>
Monitoring related configuraton for the current k8s cluster.
</td>
		</tr>
		<tr>
			<td id="monitoring--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L73">monitoring.enabled</a></div>
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
Monitor current k8s cluster. Setting it to <code>true</code> will auto configure CEEMS API server with configuration corresponding to current cluster. Note the deployment based on default values do not use any sort of authentication for CEEMS exporter/CEEMS API server/CEEMS LB/Prometheus. If kube-rbac-proxy is enabled for CEEMS components the configuration for different components needs to be setup manually by using appropriate <code>Authorization</code> headers and cluster roles. In that case, set this value to <code>false</code> and pass the configuration of different CEEMS components using corresponding values in chart.
</td>
		</tr>
		<tr>
			<td id="monitoring--clusterID">
              <div style="max-width: 250px;"><a href="./values.yaml#L81">monitoring.clusterID</a></div>
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
Current cluster ID for CEEMS. When <code>monitorCurrentCluster</code> is set to <code>true</code> and <code>clusterID</code> is empty a default based on release name will be used. To have a more human readable cluster ID we recommend users to set this to unique value.
</td>
		</tr>
		<tr>
			<td id="monitoring--updaterWebConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L86">monitoring.updaterWebConfig</a></div>
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
Web config for TSDB updater, if available. Ref: https://ceems-dev.github.io/ceems/docs/configuration/config-reference#web_client_config
</td>
		</tr>
		<tr>
			<td id="imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L88">imagePullSecrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L93">revisionHistoryLimit</a></div>
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
Number of old history to retain to allow rollback. Default Kubernetes value is set to 10
</td>
		</tr>
		<tr>
			<td id="rbac--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L97">rbac.create</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L99">rbac.extraClusterRoleRules</a></div>
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
			<td id="admissionWebhooks--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L112">admissionWebhooks.enabled</a></div>
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
Enable admission webhook to add username annotations to pods.  Must be enabled when monitoring k8s clusters. The controller will add the username annotations to pods which are needed by CEEMS API server to account for energy usage of individual users. By default, admission controller DO NOT STOP any pods from scheduling, it only adds username annotations to the pod's spec.
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--timeoutSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L114">admissionWebhooks.timeoutSeconds</a></div>
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
The default timeoutSeconds is 10 and the maximum value is 30.
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--caBundle">
              <div style="max-width: 250px;"><a href="./values.yaml#L117">admissionWebhooks.caBundle</a></div>
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
A PEM encoded CA bundle which will be used to validate the webhook's server certificate. If unspecified, system trust roots on the apiserver are used.
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L119">admissionWebhooks.annotations</a></div>
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
			<td id="admissionWebhooks--mutatingWebhookConfiguration--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L124">admissionWebhooks.mutatingWebhookConfiguration.annotations</a></div>
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
			<td id="admissionWebhooks--validatingWebhookConfiguration--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L128">admissionWebhooks.validatingWebhookConfiguration.annotations</a></div>
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
			<td id="admissionWebhooks--deployment--replicas">
              <div style="max-width: 250px;"><a href="./values.yaml#L134">admissionWebhooks.deployment.replicas</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
1
</pre>
</div>
			</td>
			<td>
Number of replicas
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--strategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L138">admissionWebhooks.deployment.strategy</a></div>
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
Strategy of the deployment
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--revisionHistoryLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L142">admissionWebhooks.deployment.revisionHistoryLimit</a></div>
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
Number of old replicasets to retain. The default value is 10, 0 will garbage-collect old replicasets.
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L146">admissionWebhooks.deployment.additionalArgs</a></div>
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
Extra arguments to admission controller. List of dicts with <code>name</code> and <code>value</code> fields for each dict.
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--serviceAccount">
              <div style="max-width: 250px;"><a href="./values.yaml#L151">admissionWebhooks.deployment.serviceAccount</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "annotations": {},
  "automountServiceAccountToken": false,
  "create": true,
  "name": ""
}
</pre>
</div>
			</td>
			<td>
Service account for CEEMS admission Webhook to use. Ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--service">
              <div style="max-width: 250px;"><a href="./values.yaml#L159">admissionWebhooks.deployment.service</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "additionalPorts": [],
  "annotations": {},
  "clusterIP": "",
  "externalIPs": [],
  "externalTrafficPolicy": "Cluster",
  "ipDualStack": {
    "enabled": false,
    "ipFamilies": [
      "IPv6",
      "IPv4"
    ],
    "ipFamilyPolicy": "PreferDualStack"
  },
  "labels": {},
  "nodePort": "",
  "type": "ClusterIP"
}
</pre>
</div>
			</td>
			<td>
Configuration for CEEMS admission Webhook service
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L171">admissionWebhooks.deployment.service.nodePort</a></div>
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
Port to expose on each node. Only used if `service.type` is <code>NodePort</code>
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--service--additionalPorts">
              <div style="max-width: 250px;"><a href="./values.yaml#L176">admissionWebhooks.deployment.service.additionalPorts</a></div>
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
Additional ports to open for CEEMS admission Webhook service Ref: https://kubernetes.io/docs/concepts/services-networking/service/#multi-port-services
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--service--externalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L180">admissionWebhooks.deployment.service.externalTrafficPolicy</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"Cluster"
</pre>
</div>
			</td>
			<td>
Denotes if this Service desires to route external traffic to node-local or cluster-wide endpoints
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L185">admissionWebhooks.deployment.service.type</a></div>
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
Service type. Possible values are <code>NodePort</code>, <code>ClusterIP</code>, <code>LoadBalancer</code>
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--service--externalIPs">
              <div style="max-width: 250px;"><a href="./values.yaml#L190">admissionWebhooks.deployment.service.externalIPs</a></div>
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
List of IP addresses at which the CEEMS admission webhook service is available Ref: https://kubernetes.io/docs/concepts/services-networking/service/#external-ips
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L194">admissionWebhooks.deployment.labels</a></div>
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
Labels to add to the admission webhook deployment
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L198">admissionWebhooks.deployment.annotations</a></div>
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
Annotations to add to the admission webhook deployment
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L202">admissionWebhooks.deployment.podLabels</a></div>
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
Labels to add to the admission webhook pod
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L206">admissionWebhooks.deployment.podAnnotations</a></div>
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
Annotations to add to the admission webhook pod
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L209">admissionWebhooks.deployment.priorityClassName</a></div>
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
Assign a PriorityClassName to pods if set
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L213">admissionWebhooks.deployment.livenessProbe</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": true,
  "failureThreshold": 3,
  "initialDelaySeconds": 30,
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
			<td id="admissionWebhooks--deployment--readinessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L223">admissionWebhooks.deployment.readinessProbe</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": true,
  "failureThreshold": 3,
  "initialDelaySeconds": 5,
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
			<td id="admissionWebhooks--deployment--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L233">admissionWebhooks.deployment.resources</a></div>
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
Resource limits & requests
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L244">admissionWebhooks.deployment.nodeSelector</a></div>
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
Define which Nodes the Pods are scheduled on. Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--tolerations">
              <div style="max-width: 250px;"><a href="./values.yaml#L249">admissionWebhooks.deployment.tolerations</a></div>
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
Tolerations for use with node taints Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ #
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L258">admissionWebhooks.deployment.affinity</a></div>
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
Assign custom affinity rules to the prometheus operator Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L269">admissionWebhooks.deployment.dnsConfig</a></div>
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
			<td id="admissionWebhooks--deployment--securityContext--fsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L281">admissionWebhooks.deployment.securityContext.fsGroup</a></div>
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
			<td id="admissionWebhooks--deployment--securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L282">admissionWebhooks.deployment.securityContext.runAsGroup</a></div>
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
			<td id="admissionWebhooks--deployment--securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L283">admissionWebhooks.deployment.securityContext.runAsNonRoot</a></div>
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
			<td id="admissionWebhooks--deployment--securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L284">admissionWebhooks.deployment.securityContext.runAsUser</a></div>
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
			<td id="admissionWebhooks--deployment--securityContext--seccompProfile--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L286">admissionWebhooks.deployment.securityContext.seccompProfile.type</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"RuntimeDefault"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--containerSecurityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L291">admissionWebhooks.deployment.containerSecurityContext</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "allowPrivilegeEscalation": false,
  "capabilities": {
    "drop": [
      "ALL"
    ]
  },
  "readOnlyRootFilesystem": true
}
</pre>
</div>
			</td>
			<td>
Container-specific security context configuration Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--deployment--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L300">admissionWebhooks.deployment.automountServiceAccountToken</a></div>
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
If <code>false</code> then the user will opt out of automounting API credentials.
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L304">admissionWebhooks.patch.enabled</a></div>
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
Enable patching webhook to configure TLS CA.
</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L306">admissionWebhooks.patch.image.registry</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"registry.k8s.io"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--image--repository">
              <div style="max-width: 250px;"><a href="./values.yaml#L307">admissionWebhooks.patch.image.repository</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ingress-nginx/kube-webhook-certgen"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L308">admissionWebhooks.patch.image.tag</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"v1.6.5"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L309">admissionWebhooks.patch.image.sha</a></div>
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
			<td id="admissionWebhooks--patch--image--pullPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L310">admissionWebhooks.patch.image.pullPolicy</a></div>
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
			<td id="admissionWebhooks--patch--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L311">admissionWebhooks.patch.resources</a></div>
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
			<td id="admissionWebhooks--patch--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L314">admissionWebhooks.patch.priorityClassName</a></div>
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
			<td id="admissionWebhooks--patch--ttlSecondsAfterFinished">
              <div style="max-width: 250px;"><a href="./values.yaml#L315">admissionWebhooks.patch.ttlSecondsAfterFinished</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
60
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L316">admissionWebhooks.patch.annotations</a></div>
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
			<td id="admissionWebhooks--patch--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L319">admissionWebhooks.patch.podAnnotations</a></div>
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
			<td id="admissionWebhooks--patch--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L320">admissionWebhooks.patch.nodeSelector</a></div>
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
			<td id="admissionWebhooks--patch--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L321">admissionWebhooks.patch.affinity</a></div>
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
			<td id="admissionWebhooks--patch--tolerations">
              <div style="max-width: 250px;"><a href="./values.yaml#L322">admissionWebhooks.patch.tolerations</a></div>
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
			<td id="admissionWebhooks--patch--securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L329">admissionWebhooks.patch.securityContext.runAsGroup</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
2000
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L330">admissionWebhooks.patch.securityContext.runAsNonRoot</a></div>
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
			<td id="admissionWebhooks--patch--securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L331">admissionWebhooks.patch.securityContext.runAsUser</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
2000
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--securityContext--seccompProfile--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L333">admissionWebhooks.patch.securityContext.seccompProfile.type</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"RuntimeDefault"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patch--serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L338">admissionWebhooks.patch.serviceAccount.create</a></div>
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
			<td id="admissionWebhooks--patch--serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L339">admissionWebhooks.patch.serviceAccount.annotations</a></div>
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
			<td id="admissionWebhooks--patch--serviceAccount--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L340">admissionWebhooks.patch.serviceAccount.automountServiceAccountToken</a></div>
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
			<td id="admissionWebhooks--createSecretJob--securityContext--allowPrivilegeEscalation">
              <div style="max-width: 250px;"><a href="./values.yaml#L345">admissionWebhooks.createSecretJob.securityContext.allowPrivilegeEscalation</a></div>
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
			<td id="admissionWebhooks--createSecretJob--securityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L346">admissionWebhooks.createSecretJob.securityContext.readOnlyRootFilesystem</a></div>
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
			<td id="admissionWebhooks--createSecretJob--securityContext--capabilities--drop[0]">
              <div style="max-width: 250px;"><a href="./values.yaml#L349">admissionWebhooks.createSecretJob.securityContext.capabilities.drop[0]</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ALL"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="admissionWebhooks--patchWebhookJob--securityContext--allowPrivilegeEscalation">
              <div style="max-width: 250px;"><a href="./values.yaml#L354">admissionWebhooks.patchWebhookJob.securityContext.allowPrivilegeEscalation</a></div>
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
			<td id="admissionWebhooks--patchWebhookJob--securityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L355">admissionWebhooks.patchWebhookJob.securityContext.readOnlyRootFilesystem</a></div>
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
			<td id="admissionWebhooks--patchWebhookJob--securityContext--capabilities--drop[0]">
              <div style="max-width: 250px;"><a href="./values.yaml#L358">admissionWebhooks.patchWebhookJob.securityContext.capabilities.drop[0]</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ALL"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="dataConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L363">dataConfig</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "path": "/var/lib/ceems_api_server",
  "retention_period": "30d",
  "update_interval": "15m"
}
</pre>
</div>
			</td>
			<td>
CEEMS API server data config Ref: https://ceems-dev.github.io/ceems/docs/configuration/config-reference#data_config
</td>
		</tr>
		<tr>
			<td id="adminConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L371">adminConfig</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "users": []
}
</pre>
</div>
			</td>
			<td>
CEEMS API server admin config Ref: https://ceems-dev.github.io/ceems/docs/configuration/config-reference#admin_config
</td>
		</tr>
		<tr>
			<td id="clusters">
              <div style="max-width: 250px;"><a href="./values.yaml#L381">clusters</a></div>
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
CEEMS API server clusters Ref: https://ceems-dev.github.io/ceems/docs/configuration/config-reference#cluster_config  If <code>monitorCurrentCluster</code> is set to <code>true</code>, there is no need to add configuration for current cluster. If custom config is needed for current cluster, set <code>monitorCurrentCluster</code> to <code>false</code> and provide config for current cluster manually here.
</td>
		</tr>
		<tr>
			<td id="updaters">
              <div style="max-width: 250px;"><a href="./values.yaml#L386">updaters</a></div>
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
CEEMS API server updaters Ref: https://ceems-dev.github.io/ceems/docs/configuration/config-reference#updater_config
</td>
		</tr>
		<tr>
			<td id="webConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L391">webConfig</a></div>
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
CEEMS API server web config Ref: https://ceems-dev.github.io/ceems/docs/configuration/basic-auth#reference
</td>
		</tr>
		<tr>
			<td id="additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L406">additionalArgs</a></div>
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
Additional arguments for CEEMS API server List of dicts with <code>name</code> and <code>value</code> fields. <code>value</code> field can be empty for name only arguments. For e.g., for `--log.level=debug` set the following

```yaml
additionalArgs:
  - name: log.level
    value: debug
```

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L414">kubeRBACProxy.enabled</a></div>
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
When enabled, creates a kube-rbac-proxy to protect the ceems-api-server and ceems-api-server http endpoint. The requests are served through the same service but requests are HTTPS.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L416">kubeRBACProxy.env</a></div>
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
Set environment variables as name/value pairs for kube-rbac-proxy
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L420">kubeRBACProxy.image.registry</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L421">kubeRBACProxy.image.repository</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L422">kubeRBACProxy.image.tag</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"v0.20.1"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L423">kubeRBACProxy.image.sha</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L424">kubeRBACProxy.image.pullPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L441">kubeRBACProxy.additionalArgs</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L446">kubeRBACProxy.containerSecurityContext</a></div>
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
Specify security settings for a Container. Allows overrides and additional options compared to (Pod) securityContext. Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L451">kubeRBACProxy.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
8020
</pre>
</div>
			</td>
			<td>
Specify the port used for the CEEMS API server container (upstream port)
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L453">kubeRBACProxy.portName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L455">kubeRBACProxy.enableHostPort</a></div>
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
Configure a hostPort. If true, hostPort will be enabled in the container and set to service.port.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--proxyEndpointsPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L459">kubeRBACProxy.proxyEndpointsPort</a></div>
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
Configure Proxy Endpoints Port. This is the port being probed for readiness
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--enableProxyEndpointsHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L461">kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
Configure a hostPort. If true, hostPort will be enabled in the container and set to proxyEndpointsPort.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L466">kubeRBACProxy.resources</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L477">kubeRBACProxy.extraVolumeMounts</a></div>
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
Additional volume mounts in the kube-rbac-proxy container.
</td>
		</tr>
		<tr>
			<td id="kubeRBACProxy--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L485">kubeRBACProxy.tls</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L494">tlsSecret.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L496">tlsSecret.caItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L498">tlsSecret.certItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L500">tlsSecret.keyItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L502">tlsSecret.secretName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ceems-api-server-tls"
</pre>
</div>
			</td>
			<td>
Name of an existing secret
</td>
		</tr>
		<tr>
			<td id="tlsSecret--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L504">tlsSecret.volumeName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ceems-api-server-tls"
</pre>
</div>
			</td>
			<td>
Name of the volume to be created
</td>
		</tr>
		<tr>
			<td id="service--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L509">service.enabled</a></div>
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
Creating a service is enabled by default
</td>
		</tr>
		<tr>
			<td id="service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L512">service.type</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L514">service.clusterIP</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L517">service.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
9020
</pre>
</div>
			</td>
			<td>
Default service port. Sets the port of the exposed container as well (NE or kubeRBACProxy). Use "servicePort" below if changing the service port only is desired.
</td>
		</tr>
		<tr>
			<td id="service--servicePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L520">service.servicePort</a></div>
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
Service port. Use this field if you wish to set a different service port without changing the container port ("port" above).
</td>
		</tr>
		<tr>
			<td id="service--targetPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L522">service.targetPort</a></div>
            </td>
            <td>
int or string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
9020
</pre>
</div>
			</td>
			<td>
Targeted port in the pod. Must refer to an open container port (<code>port</code> or <code>portName</code>).
</td>
		</tr>
		<tr>
			<td id="service--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L524">service.portName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"metrics"
</pre>
</div>
			</td>
			<td>
Name of the service port. Sets the port name of the main container (NE) as well.
</td>
		</tr>
		<tr>
			<td id="service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L526">service.nodePort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L529">service.listenOnAllInterfaces</a></div>
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
If true, CEEMS API server will listen on all interfaces
</td>
		</tr>
		<tr>
			<td id="service--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L532">service.annotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L533">service.labels</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L537">service.ipDualStack</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L544">service.externalTrafficPolicy</a></div>
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
External traffic policy setting (Cluster, Local) Ref: https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies
</td>
		</tr>
		<tr>
			<td id="service--internalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L547">service.internalTrafficPolicy</a></div>
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
Internal traffic policy setting (Cluster, Local) Ref: https://kubernetes.io/docs/reference/networking/virtual-ips/#traffic-policies
</td>
		</tr>
		<tr>
			<td id="networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L551">networkPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L561">env</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L566">updateStrategy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L574">resources</a></div>
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
			<td id="persistence--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L589">persistence.enabled</a></div>
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
Enable persistant volumes
</td>
		</tr>
		<tr>
			<td id="persistence--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L591">persistence.type</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"pvc"
</pre>
</div>
			</td>
			<td>
Type of persistence volume: <code>pvc</code> or <code>statefulset</code>
</td>
		</tr>
		<tr>
			<td id="persistence--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L594">persistence.volumeName</a></div>
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
storageClassName: default (Optional) Use this to bind the claim to an existing PersistentVolume (PV) by name.
</td>
		</tr>
		<tr>
			<td id="persistence--accessModes">
              <div style="max-width: 250px;"><a href="./values.yaml#L596">persistence.accessModes</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[
  "ReadWriteOnce"
]
</pre>
</div>
			</td>
			<td>
PV access modes.
</td>
		</tr>
		<tr>
			<td id="persistence--size">
              <div style="max-width: 250px;"><a href="./values.yaml#L599">persistence.size</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"10Gi"
</pre>
</div>
			</td>
			<td>
Size of PV.
</td>
		</tr>
		<tr>
			<td id="persistence--finalizers">
              <div style="max-width: 250px;"><a href="./values.yaml#L601">persistence.finalizers</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[
  "kubernetes.io/pvc-protection"
]
</pre>
</div>
			</td>
			<td>
annotations: {}
</td>
		</tr>
		<tr>
			<td id="persistence--extraPvcLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L609">persistence.extraPvcLabels</a></div>
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
Extra labels to apply to a PVC.
</td>
		</tr>
		<tr>
			<td id="persistence--disableWarning">
              <div style="max-width: 250px;"><a href="./values.yaml#L610">persistence.disableWarning</a></div>
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
			<td id="persistence--inMemory">
              <div style="max-width: 250px;"><a href="./values.yaml#L615">persistence.inMemory</a></div>
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
If <code>persistence</code> is not enabled, this allows to mount the local storage in-memory to improve performance
</td>
		</tr>
		<tr>
			<td id="persistence--lookupVolumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L625">persistence.lookupVolumeName</a></div>
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
If <code>lookupVolumeName</code> is set to <code>true</code>, Helm will attempt to retrieve the current value of `spec.volumeName` and incorporate it into the template.
</td>
		</tr>
		<tr>
			<td id="restartPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L629">restartPolicy</a></div>
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
Specify the container restart policy passed to the CEEMS API server container Possible Values: `Always|OnFailure|Never`. Default value is <code>Always</code>.
</td>
		</tr>
		<tr>
			<td id="serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L633">serviceAccount.create</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L636">serviceAccount.name</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L637">serviceAccount.annotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L638">serviceAccount.imagePullSecrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L639">serviceAccount.automountServiceAccountToken</a></div>
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
			<td id="securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L642">securityContext.runAsNonRoot</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L643">securityContext.runAsUser</a></div>
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
			<td id="securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L644">securityContext.runAsGroup</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L647">containerSecurityContext.privileged</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L648">containerSecurityContext.readOnlyRootFilesystem</a></div>
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
			<td id="hostNetwork">
              <div style="max-width: 250px;"><a href="./values.yaml#L654">hostNetwork</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L657">hostPID</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L660">hostIPC</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L664">affinity</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L675">podAnnotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L678">podLabels</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L681">deployAnnotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L684">dnsConfig</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L697">nodeSelector</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L702">terminationGracePeriodSeconds</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L705">tolerations[0].effect</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L706">tolerations[0].operator</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L710">terminationMessageParams</a></div>
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
			<td id="terminationMessageParams--terminationMessagePath">
              <div style="max-width: 250px;"><a href="./values.yaml#L713">terminationMessageParams.terminationMessagePath</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"/dev/termination-log"
</pre>
</div>
			</td>
			<td>
If enabled, specify the path for termination messages
</td>
		</tr>
		<tr>
			<td id="terminationMessageParams--terminationMessagePolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L715">terminationMessageParams.terminationMessagePolicy</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"File"
</pre>
</div>
			</td>
			<td>
If enabled, specify the policy for termination messages
</td>
		</tr>
		<tr>
			<td id="priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L718">priorityClassName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L722">extraHostVolumeMounts</a></div>
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
Additional mounts from the host to CEEMS API server container
</td>
		</tr>
		<tr>
			<td id="configmaps">
              <div style="max-width: 250px;"><a href="./values.yaml#L733">configmaps</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L739">secrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L745">extraInitContainers</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L748">extraManifests</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L758">extraVolumes</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L766">extraVolumeMounts</a></div>
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
Extra volume mounts in the CEEMS API server container
</td>
		</tr>
		<tr>
			<td id="livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L773">livenessProbe</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L782">readinessProbe</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L790">version</a></div>
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

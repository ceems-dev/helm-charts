<!-- textlint-disable -->

# kube-ceems

![Version: 0.39.0](https://img.shields.io/badge/Version-0.39.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.12.2](https://img.shields.io/badge/AppVersion-0.12.2-informational?style=flat-square)

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
| https://grafana.github.io/helm-charts | pyroscope | 1.18.1 |
| https://prometheus-community.github.io/helm-charts | kube-prometheus-stack | 81.5.* |

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
CEEMS API server (`ceemsAPIServer.admissionWebhooks.enabled`) and one instance of prometheus-operator
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
Provide a name in place of kube-ceems for `app:` labels
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
			<td id="monitorCurrentCluster">
              <div style="max-width: 250px;"><a href="./values.yaml#L70">monitorCurrentCluster</a></div>
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
Monitor current k8s cluster. Setting it to <code>true</code> will auto configure CEEMS API server and CEEMS LB (if enabled) with configuration corresponding to current cluster. Note the deployment based on default values do not use any sort of authentication for CEEMS exporter/CEEMS API server/CEEMS LB/Prometheus. If kube-rbac-proxy is enabled for CEEMS components the configuration for different components needs to be setup manually by using appropriate <code>Authorization</code> headers and cluster roles. In that case, set this value to <code>false</code> and pass the configuration of different CEEMS components using corresponding values in chart.
</td>
		</tr>
		<tr>
			<td id="clusterID">
              <div style="max-width: 250px;"><a href="./values.yaml#L78">clusterID</a></div>
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
Current cluster ID for CEEMS. When <code>monitorCurrentCluster</code> is set to <code>true</code> and <code>clusterID</code> is empty a default value of `ceems-k8s-0` will be used. To have a more human readable cluster ID we recommend users to set this to unique value.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L82">ceemsExporter.enabled</a></div>
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
			<td id="ceemsExporter--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L84">ceemsExporter.imagePullSecrets</a></div>
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
			<td id="ceemsExporter--revisionHistoryLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L89">ceemsExporter.revisionHistoryLimit</a></div>
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
			<td id="ceemsExporter--rbac">
              <div style="max-width: 250px;"><a href="./values.yaml#L92">ceemsExporter.rbac</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "create": true,
  "extraClusterRoleRules": []
}
</pre>
</div>
			</td>
			<td>
Use RBAC resources
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--rbac--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L94">ceemsExporter.rbac.create</a></div>
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
			<td id="ceemsExporter--rbac--extraClusterRoleRules">
              <div style="max-width: 250px;"><a href="./values.yaml#L96">ceemsExporter.rbac.extraClusterRoleRules</a></div>
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
			<td id="ceemsExporter--collectors--k8s--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L104">ceemsExporter.collectors.k8s.enabled</a></div>
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
Enable k8s collector
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--k8s--kubeletSocketDirectory">
              <div style="max-width: 250px;"><a href="./values.yaml#L106">ceemsExporter.collectors.k8s.kubeletSocketDirectory</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"/var/lib/kubelet/pod-resources"
</pre>
</div>
			</td>
			<td>
Kubelet pod resources socket directory
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--slurm--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L109">ceemsExporter.collectors.slurm.enabled</a></div>
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
Enable SLURM collector
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--slurm--configDirectory">
              <div style="max-width: 250px;"><a href="./values.yaml#L112">ceemsExporter.collectors.slurm.configDirectory</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"/etc/slurm"
</pre>
</div>
			</td>
			<td>
If the SLURM configuration files are located in non-standard location, configure it here.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--libvirt--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L115">ceemsExporter.collectors.libvirt.enabled</a></div>
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
Enable libvirt collector (for Openstack)
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--ipmi--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L118">ceemsExporter.collectors.ipmi.enabled</a></div>
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
Enable IPMI collector
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--ipmi--device">
              <div style="max-width: 250px;"><a href="./values.yaml#L120">ceemsExporter.collectors.ipmi.device</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"/dev/ipmi0"
</pre>
</div>
			</td>
			<td>
IPMI device file path.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--ipmi--monitorPowerEnergySensorReadings">
              <div style="max-width: 250px;"><a href="./values.yaml#L122">ceemsExporter.collectors.ipmi.monitorPowerEnergySensorReadings</a></div>
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
Monitor power and energy sensor readings
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--ipmi--monitorSensorIDs">
              <div style="max-width: 250px;"><a href="./values.yaml#L124">ceemsExporter.collectors.ipmi.monitorSensorIDs</a></div>
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
Monitor sensor IDs
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--redfish--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L127">ceemsExporter.collectors.redfish.enabled</a></div>
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
Enable Redfish collector
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--redfish--chassisNames">
              <div style="max-width: 250px;"><a href="./values.yaml#L129">ceemsExporter.collectors.redfish.chassisNames</a></div>
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
Chassis name(s) that provide power usage of host ONLY (excluding GPU power usage)
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--redfish--config">
              <div style="max-width: 250px;"><a href="./values.yaml#L132">ceemsExporter.collectors.redfish.config</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "external_url": "",
  "hostname": "",
  "password": "",
  "port": 443,
  "protocol": "https",
  "timeout": 5000,
  "use_session_token": true,
  "username": ""
}
</pre>
</div>
			</td>
			<td>
Redfish collector config. More info in <a target="_blank" href="https://ceems-dev.github.io/ceems/docs/configuration/ceems-exporter#redfish-collector">docs</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--redfish--config--external_url">
              <div style="max-width: 250px;"><a href="./values.yaml#L137">ceemsExporter.collectors.redfish.config.external_url</a></div>
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
When redfishProxy.enabled is set to true, it will be automatically set to the service URL of redfish proxy
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--hwmon--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L144">ceemsExporter.collectors.hwmon.enabled</a></div>
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
Enable hwmon collector
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--hwmon--chipNames">
              <div style="max-width: 250px;"><a href="./values.yaml#L146">ceemsExporter.collectors.hwmon.chipNames</a></div>
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
Chip name(s) that provide power usage of host ONLY (excluding GPU power usage)
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--crayPMC--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L149">ceemsExporter.collectors.crayPMC.enabled</a></div>
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
Enable cray PM counters
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--rapl--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L152">ceemsExporter.collectors.rapl.enabled</a></div>
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
Enable RAPL collector
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--emissions--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L162">ceemsExporter.collectors.emissions.enabled</a></div>
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
Enable emissions collector. As only a single instance of emission collector must be run, it is installed as a separate deployment different from daemonset (which runs on all nodes). The deployment will share the same configuration of daemonset except for the keys in the <code>deploy</code> section. A very minimal deployment is used for emissions exporter meaning that no extra init containers, secrets, configmaps are mounted.  If kube-rbac-proxy is enabled on daemonset, it will be enabled on deployment as well with the same settings.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--emissions--countryCode">
              <div style="max-width: 250px;"><a href="./values.yaml#L168">ceemsExporter.collectors.emissions.countryCode</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ZZ"
</pre>
</div>
			</td>
			<td>
Country code for estimating emissions. By default world average is used. Use an appropriate ISO 3166-1 alpha-2 country code to get static emission factors for that country. When a different country code is used, uncomment <code>owid</code> provider under <code>providers</code> key.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--emissions--providers">
              <div style="max-width: 250px;"><a href="./values.yaml#L170">ceemsExporter.collectors.emissions.providers</a></div>
            </td>
            <td>
list
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
[
  "global"
]
</pre>
</div>
			</td>
			<td>
Emission factor providers
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--emissions--deploy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L180">ceemsExporter.collectors.emissions.deploy.env</a></div>
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
Environment variables to set on emissions exporter deployment. Typically used to setup API keys and login credentials for dynamic emission factor providers
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--emissions--deploy--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L186">ceemsExporter.collectors.emissions.deploy.affinity</a></div>
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
Affinity for deployment pods where emissions collector will be deployed. The node where this pod will be deployed must have access to internet when dynamic emission factors are enabled.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--emissions--deploy--deploymentAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L195">ceemsExporter.collectors.emissions.deploy.deploymentAnnotations</a></div>
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
Annotations to be added to ceems exporter deployment
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--collectors--emissions--deploy--networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L197">ceemsExporter.collectors.emissions.deploy.networkPolicy</a></div>
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
Set a <code>NetworkPolicy</code> for deployment.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--eBPFProfiling--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L208">ceemsExporter.eBPFProfiling.enabled</a></div>
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
Enable eBPF based profiling
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--eBPFProfiling--config">
              <div style="max-width: 250px;"><a href="./values.yaml#L212">ceemsExporter.eBPFProfiling.config</a></div>
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
<a target="_blank" href="https://ceems-dev.github.io/ceems/docs/configuration/ceems-exporter#ebpf-based-continuous-profiling">Profiling config</a>. When `eBPFProfiling.enabled` is set to <code>true</code>, config must be provided to include client config of Pyroscope server.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--webConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L216">ceemsExporter.webConfig</a></div>
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
CEEMS exporter web config Ref: https://ceems-dev.github.io/ceems/docs/configuration/basic-auth#reference
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L234">ceemsExporter.additionalArgs</a></div>
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
Additional arguments for CEEMS exporter. Any other collectors that are not presented under `ceemsExporter.collectors` can be turned on here.  List of dicts with <code>name</code> and <code>value</code> fields. <code>value</code> field can be empty for name only arguments. For e.g., for `--collector.k8s --log.level=debug` set the following
```yaml
additionalArgs:
  - name: collector.k8s
  - name: log.level
    value: debug
```

</td>
		</tr>
		<tr>
			<td id="ceemsExporter--kubeRBACProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L243">ceemsExporter.kubeRBACProxy.enabled</a></div>
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
When enabled, creates a kube-rbac-proxy to protect the CEEMS exporter http endpoint. The requests are served through the same service but requests are HTTPS.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--kubeRBACProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L245">ceemsExporter.kubeRBACProxy.env</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L249">ceemsExporter.kubeRBACProxy.image.registry</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--image--repository">
              <div style="max-width: 250px;"><a href="./values.yaml#L250">ceemsExporter.kubeRBACProxy.image.repository</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L251">ceemsExporter.kubeRBACProxy.image.tag</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L252">ceemsExporter.kubeRBACProxy.image.sha</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--image--pullPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L253">ceemsExporter.kubeRBACProxy.image.pullPolicy</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L270">ceemsExporter.kubeRBACProxy.additionalArgs</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--containerSecurityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L275">ceemsExporter.kubeRBACProxy.containerSecurityContext</a></div>
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
Specify security settings for a Container. Allows overrides and additional options compared to (Pod) <code>securityContext</code>. Ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--kubeRBACProxy--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L280">ceemsExporter.kubeRBACProxy.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
8010
</pre>
</div>
			</td>
			<td>
Specify the port used for the CEEMS exporter container (upstream port)
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--kubeRBACProxy--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L282">ceemsExporter.kubeRBACProxy.portName</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--enableHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L284">ceemsExporter.kubeRBACProxy.enableHostPort</a></div>
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
Configure a <code>hostPort</code>. If <code>true</code>, <code>hostPort</code> will be enabled in the container and set to service.port.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--kubeRBACProxy--proxyEndpointsPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L288">ceemsExporter.kubeRBACProxy.proxyEndpointsPort</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--enableProxyEndpointsHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L291">ceemsExporter.kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
Configure a <code>hostPort</code> for Proxy. If <code>true</code>, <code>hostPort</code> will be enabled in the container and set to proxyEndpointsPort.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--kubeRBACProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L296">ceemsExporter.kubeRBACProxy.resources</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L307">ceemsExporter.kubeRBACProxy.extraVolumeMounts</a></div>
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
			<td id="ceemsExporter--kubeRBACProxy--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L315">ceemsExporter.kubeRBACProxy.tls</a></div>
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
<code>tls</code> enables using TLS resources from a volume on secret referred to in tlsSecret below. When enabling <code>tlsClientAuth</code>, client CA certificate must be set in tlsSecret.caItem. Ref. https://github.com/brancz/kube-rbac-proxy/issues/187
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--tlsSecret--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L324">ceemsExporter.tlsSecret.enabled</a></div>
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
			<td id="ceemsExporter--tlsSecret--caItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L326">ceemsExporter.tlsSecret.caItem</a></div>
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
			<td id="ceemsExporter--tlsSecret--certItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L328">ceemsExporter.tlsSecret.certItem</a></div>
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
			<td id="ceemsExporter--tlsSecret--keyItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L330">ceemsExporter.tlsSecret.keyItem</a></div>
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
			<td id="ceemsExporter--tlsSecret--secretName">
              <div style="max-width: 250px;"><a href="./values.yaml#L332">ceemsExporter.tlsSecret.secretName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ceems-exporter-tls"
</pre>
</div>
			</td>
			<td>
Name of an existing secret
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--tlsSecret--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L334">ceemsExporter.tlsSecret.volumeName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"ceems-exporter-tls"
</pre>
</div>
			</td>
			<td>
Name of the volume to be created
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L338">ceemsExporter.service.enabled</a></div>
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
Creating a service is enabled by default for CEEMS exporter.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L341">ceemsExporter.service.type</a></div>
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
			<td id="ceemsExporter--service--clusterIP">
              <div style="max-width: 250px;"><a href="./values.yaml#L343">ceemsExporter.service.clusterIP</a></div>
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
			<td id="ceemsExporter--service--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L346">ceemsExporter.service.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
9010
</pre>
</div>
			</td>
			<td>
Default service port. Sets the port of the exposed container as well (NE or kubeRBACProxy). Use "servicePort" below if changing the service port only is desired.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--servicePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L349">ceemsExporter.service.servicePort</a></div>
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
			<td id="ceemsExporter--service--targetPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L351">ceemsExporter.service.targetPort</a></div>
            </td>
            <td>
int or string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
9010
</pre>
</div>
			</td>
			<td>
Targeted port in the pod. Must refer to an open container port ("port" or "portName").
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L353">ceemsExporter.service.portName</a></div>
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
			<td id="ceemsExporter--service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L355">ceemsExporter.service.nodePort</a></div>
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
Port number for service type NodePort
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--listenOnAllInterfaces">
              <div style="max-width: 250px;"><a href="./values.yaml#L358">ceemsExporter.service.listenOnAllInterfaces</a></div>
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
If <code>true</code>, CEEMS exporter will listen on all interfaces
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L361">ceemsExporter.service.annotations</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "prometheus.io/scrape": "true"
}
</pre>
</div>
			</td>
			<td>
Additional annotations for the service
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L365">ceemsExporter.service.labels</a></div>
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
Additional labels for the service
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--service--ipDualStack">
              <div style="max-width: 250px;"><a href="./values.yaml#L369">ceemsExporter.service.ipDualStack</a></div>
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
			<td id="ceemsExporter--service--externalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L376">ceemsExporter.service.externalTrafficPolicy</a></div>
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
			<td id="ceemsExporter--service--internalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L380">ceemsExporter.service.internalTrafficPolicy</a></div>
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
			<td id="ceemsExporter--networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L383">ceemsExporter.networkPolicy</a></div>
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
Set a <code>NetworkPolicy</code> for daemonset.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L393">ceemsExporter.env</a></div>
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
Additional environment variables that will be passed to the daemonset
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--defaultRules--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L406">ceemsExporter.prometheus.defaultRules.create</a></div>
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
Create default rules for CEEMS monitoring. These rules are necessary for Grafana dashboard panels.  If default rules are not desired or not enough, additional custom rules to <code>additionalPrometheusRules</code> key under `kube-prometheus-stack` section.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--defaultRules--rules--nvidiaGPU">
              <div style="max-width: 250px;"><a href="./values.yaml#L413">ceemsExporter.prometheus.defaultRules.rules.nvidiaGPU</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false,
  "profiling": false
}
</pre>
</div>
			</td>
			<td>
When there are NVIDIA GPUs in the cluster, enable <code>nvidiaGPU</code> rules. NVIDIA GPU operator deploys a DCGM exporter and current helm chart scrapes that exporter based on default labels used. If the deployed DCGM exporter supports profiling metrics, enable <code>profiling</code> as well.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--defaultRules--rules--amdGPU">
              <div style="max-width: 250px;"><a href="./values.yaml#L424">ceemsExporter.prometheus.defaultRules.rules.amdGPU</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false,
  "metricPrefix": "",
  "profiling": false
}
</pre>
</div>
			</td>
			<td>
When there are AMD GPUs in the cluster, enabled <code>amdGPU</code> rules. AMD GPU operator deploys a device metrics exporter and current helm chart scrapes that exporter based on default labels used. If <code>metricsPrefix</code> in device metrics exporter is used anything other than empty string, set the same here in <code>metricPrefix</code>. Similarly when devices metrics exporter is configured to export profiling metrics as well, set <code>profiling</code> to true.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--defaultRules--pue">
              <div style="max-width: 250px;"><a href="./values.yaml#L430">ceemsExporter.prometheus.defaultRules.pue</a></div>
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
PUE factor to be used in rules for power usage
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--defaultRules--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L433">ceemsExporter.prometheus.defaultRules.labels</a></div>
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
Labels for default CEEMS rules
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--defaultRules--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L435">ceemsExporter.prometheus.defaultRules.annotations</a></div>
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
Annotations for default CEEMS rules
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L439">ceemsExporter.prometheus.monitor.enabled</a></div>
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
Enable Prometheus service monitor
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--dcgmExporterEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L442">ceemsExporter.prometheus.monitor.dcgmExporterEnabled</a></div>
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
When enabled, service monitor for NVIDIA DCGM exporter will be installed to add NVIDIA DCGM exporter to scrape pools. The exporter pods and service can be running in any namespace. There is no need to run them in current chart's namespace.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--amdDeviceMetricsExporterEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L445">ceemsExporter.prometheus.monitor.amdDeviceMetricsExporterEnabled</a></div>
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
When enabled, service monitor for AMD device metrics exporter will be installed to add AMD device metrics exporter to scrape pools. The exporter pods and service can be running in any namespace. There is no need to run them in current chart's namespace.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--additionalLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L447">ceemsExporter.prometheus.monitor.additionalLabels</a></div>
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
Additional labels, e.g. setting a label for pod monitor selector as set in prometheus
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--namespace">
              <div style="max-width: 250px;"><a href="./values.yaml#L449">ceemsExporter.prometheus.monitor.namespace</a></div>
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
Namespace in which to deploy the pod monitor. Defaults to the release namespace.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--jobLabel">
              <div style="max-width: 250px;"><a href="./values.yaml#L451">ceemsExporter.prometheus.monitor.jobLabel</a></div>
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
The label to use to retrieve the job name from. Defaults to label app.kubernetes.io/name.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--apiVersion">
              <div style="max-width: 250px;"><a href="./values.yaml#L453">ceemsExporter.prometheus.monitor.apiVersion</a></div>
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
prometheus.monitor.apiVersion ApiVersion for the serviceMonitor Resource(defaults to "monitoring.coreos.com/v1")
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--podTargetLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L456">ceemsExporter.prometheus.monitor.podTargetLabels</a></div>
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
List of pod labels to add to ceems exporter metrics. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#servicemonitor">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--targetLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L459">ceemsExporter.prometheus.monitor.targetLabels</a></div>
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
List of target labels to add to ceems exporter metrics. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#servicemonitor">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L462">ceemsExporter.prometheus.monitor.scheme</a></div>
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
Scheme/protocol to use for scraping.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L465">ceemsExporter.prometheus.monitor.basicAuth</a></div>
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
BasicAuth allow an endpoint to authenticate over basic authentication. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#basicauth">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--tlsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L468">ceemsExporter.prometheus.monitor.tlsConfig</a></div>
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
TLS configuration to use when scraping the endpoint. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#v1.SafeTLSConfig">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--authorization">
              <div style="max-width: 250px;"><a href="./values.yaml#L471">ceemsExporter.prometheus.monitor.authorization</a></div>
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
Authorization section for this endpoint. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#safeauthorization">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--oauth2">
              <div style="max-width: 250px;"><a href="./values.yaml#L474">ceemsExporter.prometheus.monitor.oauth2</a></div>
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
OAuth2 for the URL. Only valid in Prometheus versions 2.27.0 and newer. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#oauth2">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--proxyUrl">
              <div style="max-width: 250px;"><a href="./values.yaml#L477">ceemsExporter.prometheus.monitor.proxyUrl</a></div>
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
URL of a proxy that should be used for scraping.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--selectorOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L479">ceemsExporter.prometheus.monitor.selectorOverride</a></div>
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
Override serviceMonitor selector
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--attachMetadata">
              <div style="max-width: 250px;"><a href="./values.yaml#L482">ceemsExporter.prometheus.monitor.attachMetadata</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "node": false
}
</pre>
</div>
			</td>
			<td>
Attach node metadata to discovered targets. Requires Prometheus v2.35.0 and above.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--interval">
              <div style="max-width: 250px;"><a href="./values.yaml#L486">ceemsExporter.prometheus.monitor.interval</a></div>
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
Interval at which endpoints should be scraped. If not specified Prometheus’ global scrape interval is used.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--scrapeTimeout">
              <div style="max-width: 250px;"><a href="./values.yaml#L488">ceemsExporter.prometheus.monitor.scrapeTimeout</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"10s"
</pre>
</div>
			</td>
			<td>
Timeout after which the scrape is ended. If not specified, the Prometheus global scrape interval is used.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--honorTimestamps">
              <div style="max-width: 250px;"><a href="./values.yaml#L490">ceemsExporter.prometheus.monitor.honorTimestamps</a></div>
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
HonorTimestamps controls whether Prometheus respects the timestamps present in scraped data.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--honorLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L492">ceemsExporter.prometheus.monitor.honorLabels</a></div>
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
HonorLabels chooses the metric’s labels on collisions with target labels.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--enableHttp2">
              <div style="max-width: 250px;"><a href="./values.yaml#L494">ceemsExporter.prometheus.monitor.enableHttp2</a></div>
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
Whether to enable HTTP2. Default <code>false</code>.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--filterRunning">
              <div style="max-width: 250px;"><a href="./values.yaml#L497">ceemsExporter.prometheus.monitor.filterRunning</a></div>
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
Drop pods that are not running. (Failed, Succeeded). Enabled by default. More <a target="_blank" href="https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--followRedirects">
              <div style="max-width: 250px;"><a href="./values.yaml#L499">ceemsExporter.prometheus.monitor.followRedirects</a></div>
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
FollowRedirects configures whether scrape requests follow HTTP 3xx redirects. Default <code>false</code>.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--params">
              <div style="max-width: 250px;"><a href="./values.yaml#L501">ceemsExporter.prometheus.monitor.params</a></div>
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
Optional HTTP URL parameters
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--relabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L507">ceemsExporter.prometheus.monitor.relabelings</a></div>
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
RelabelConfigs to apply to samples before scraping. Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields. The original scrape job’s name is available via the __tmp_prometheus_job_name label. More <a target="_blank" href="https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--metricRelabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L509">ceemsExporter.prometheus.monitor.metricRelabelings</a></div>
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
MetricRelabelConfigs to apply to samples before ingestion.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--sampleLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L512">ceemsExporter.prometheus.monitor.sampleLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
SampleLimit defines per-scrape limit on number of scraped samples that will be accepted.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--targetLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L514">ceemsExporter.prometheus.monitor.targetLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
TargetLimit defines a limit on the number of scraped targets that will be accepted.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--labelLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L517">ceemsExporter.prometheus.monitor.labelLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
Per-scrape limit on number of labels that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--labelNameLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L520">ceemsExporter.prometheus.monitor.labelNameLengthLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
Per-scrape limit on length of labels name that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--monitor--labelValueLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L523">ceemsExporter.prometheus.monitor.labelValueLengthLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
Per-scrape limit on length of labels value that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L536">ceemsExporter.prometheus.podMonitor.enabled</a></div>
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
Enable Prometheus Pod monitor. <code>PodMonitor</code> defines monitoring for a set of pods. Ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#podmonitor  Using a <code>PodMonitor</code> may be preferred in some environments where there is very large number of Node Exporter endpoints (1000+) behind a single service. The <code>PodMonitor</code> is disabled by default. When switching from <code>ServiceMonitor</code> to <code>PodMonitor</code>, the time series resulting from the configuration through <code>PodMonitor</code> may have different labels. For instance, there will not be the service label any longer which might affect PromQL queries selecting that label.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--namespace">
              <div style="max-width: 250px;"><a href="./values.yaml#L538">ceemsExporter.prometheus.podMonitor.namespace</a></div>
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
Namespace in which to deploy the pod monitor. Defaults to the release namespace.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--additionalLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L540">ceemsExporter.prometheus.podMonitor.additionalLabels</a></div>
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
Additional labels, e.g. setting a label for pod monitor selector as set in prometheus
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--podTargetLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L543">ceemsExporter.prometheus.podMonitor.podTargetLabels</a></div>
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
PodTargetLabels transfers labels of the Kubernetes Pod onto the target.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--apiVersion">
              <div style="max-width: 250px;"><a href="./values.yaml#L545">ceemsExporter.prometheus.podMonitor.apiVersion</a></div>
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
apiVersion defaults to monitoring.coreos.com/v1.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--selectorOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L547">ceemsExporter.prometheus.podMonitor.selectorOverride</a></div>
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
Override pod selector to select pod objects.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--attachMetadata">
              <div style="max-width: 250px;"><a href="./values.yaml#L549">ceemsExporter.prometheus.podMonitor.attachMetadata</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "node": false
}
</pre>
</div>
			</td>
			<td>
Attach node metadata to discovered targets. Requires Prometheus v2.35.0 and above.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--jobLabel">
              <div style="max-width: 250px;"><a href="./values.yaml#L552">ceemsExporter.prometheus.podMonitor.jobLabel</a></div>
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
The label to use to retrieve the job name from. Defaults to label app.kubernetes.io/name.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L555">ceemsExporter.prometheus.podMonitor.scheme</a></div>
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
Scheme/protocol to use for scraping.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--path">
              <div style="max-width: 250px;"><a href="./values.yaml#L557">ceemsExporter.prometheus.podMonitor.path</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"/metrics"
</pre>
</div>
			</td>
			<td>
Path to scrape metrics at.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L561">ceemsExporter.prometheus.podMonitor.basicAuth</a></div>
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
BasicAuth allow an endpoint to authenticate over basic authentication. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#basicauth">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--tlsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L564">ceemsExporter.prometheus.podMonitor.tlsConfig</a></div>
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
TLS configuration to use when scraping the endpoint. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#v1.SafeTLSConfig">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--authorization">
              <div style="max-width: 250px;"><a href="./values.yaml#L567">ceemsExporter.prometheus.podMonitor.authorization</a></div>
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
Authorization section for this endpoint. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#safeauthorization">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--oauth2">
              <div style="max-width: 250px;"><a href="./values.yaml#L570">ceemsExporter.prometheus.podMonitor.oauth2</a></div>
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
OAuth2 for the URL. Only valid in Prometheus versions 2.27.0 and newer. More <a target="_blank" href="https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/api-reference/api.md#oauth2">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--proxyUrl">
              <div style="max-width: 250px;"><a href="./values.yaml#L573">ceemsExporter.prometheus.podMonitor.proxyUrl</a></div>
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
ProxyURL eg http://proxyserver:2195. Directs scrapes through proxy to this endpoint.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--interval">
              <div style="max-width: 250px;"><a href="./values.yaml#L575">ceemsExporter.prometheus.podMonitor.interval</a></div>
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
Interval at which endpoints should be scraped. If not specified Prometheus’ global scrape interval is used.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--scrapeTimeout">
              <div style="max-width: 250px;"><a href="./values.yaml#L577">ceemsExporter.prometheus.podMonitor.scrapeTimeout</a></div>
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
Timeout after which the scrape is ended. If not specified, the Prometheus global scrape interval is used.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--honorTimestamps">
              <div style="max-width: 250px;"><a href="./values.yaml#L579">ceemsExporter.prometheus.podMonitor.honorTimestamps</a></div>
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
HonorTimestamps controls whether Prometheus respects the timestamps present in scraped data.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--honorLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L581">ceemsExporter.prometheus.podMonitor.honorLabels</a></div>
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
HonorLabels chooses the metric’s labels on collisions with target labels.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--enableHttp2">
              <div style="max-width: 250px;"><a href="./values.yaml#L583">ceemsExporter.prometheus.podMonitor.enableHttp2</a></div>
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
Whether to enable HTTP2. Default false.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--filterRunning">
              <div style="max-width: 250px;"><a href="./values.yaml#L586">ceemsExporter.prometheus.podMonitor.filterRunning</a></div>
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
Drop pods that are not running. (Failed, Succeeded). Enabled by default. More <a target="_blank" href="https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--followRedirects">
              <div style="max-width: 250px;"><a href="./values.yaml#L588">ceemsExporter.prometheus.podMonitor.followRedirects</a></div>
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
<code>followRedirects</code> configures whether scrape requests follow HTTP 3xx redirects. Default false.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--params">
              <div style="max-width: 250px;"><a href="./values.yaml#L590">ceemsExporter.prometheus.podMonitor.params</a></div>
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
Optional HTTP URL parameters
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--relabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L596">ceemsExporter.prometheus.podMonitor.relabelings</a></div>
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
<code>RelabelConfigs</code> to apply to samples before scraping. Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields. The original scrape job’s name is available via the __tmp_prometheus_job_name label. More <a target="_blank" href="https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config">info</a>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--metricRelabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L598">ceemsExporter.prometheus.podMonitor.metricRelabelings</a></div>
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
MetricRelabelConfigs to apply to samples before ingestion.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--sampleLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L601">ceemsExporter.prometheus.podMonitor.sampleLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
<code>SampleLimit</code> defines per-scrape limit on number of scraped samples that will be accepted.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--targetLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L603">ceemsExporter.prometheus.podMonitor.targetLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
<code>TargetLimit</code> defines a limit on the number of scraped targets that will be accepted.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--labelLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L606">ceemsExporter.prometheus.podMonitor.labelLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
Per-scrape limit on number of labels that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--labelNameLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L609">ceemsExporter.prometheus.podMonitor.labelNameLengthLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
Per-scrape limit on length of labels name that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--prometheus--podMonitor--labelValueLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L612">ceemsExporter.prometheus.podMonitor.labelValueLengthLimit</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
0
</pre>
</div>
			</td>
			<td>
Per-scrape limit on length of labels value that will be accepted for a sample. Only valid in Prometheus versions 2.27.0 and newer.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--updateStrategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L615">ceemsExporter.updateStrategy</a></div>
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
			<td id="ceemsExporter--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L623">ceemsExporter.resources</a></div>
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
			<td id="ceemsExporter--restartPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L636">ceemsExporter.restartPolicy</a></div>
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
Specify the container restart policy passed to the CEEMS Exporter container Possible Values: `Always|OnFailure|Never`. Default is <code>Always</code>.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L640">ceemsExporter.serviceAccount.create</a></div>
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
Specifies whether a ServiceAccount should be created
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--serviceAccount--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L643">ceemsExporter.serviceAccount.name</a></div>
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
The name of the ServiceAccount to use. If not set and create is true, a name is generated using the fullname template
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L644">ceemsExporter.serviceAccount.annotations</a></div>
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
			<td id="ceemsExporter--serviceAccount--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L645">ceemsExporter.serviceAccount.imagePullSecrets</a></div>
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
			<td id="ceemsExporter--serviceAccount--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L647">ceemsExporter.serviceAccount.automountServiceAccountToken</a></div>
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
Whether to auto mount service token into pods.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--securityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L652">ceemsExporter.securityContext</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "fsGroup": 65534,
  "runAsNonRoot": false,
  "runAsUser": 0
}
</pre>
</div>
			</td>
			<td>
Important to set <code>fsGroup</code> to read secret mounts. By default exporter will drop privileges and run as <code>nobody</code> user. If `--security.run-as-user` is set to a different user, use the primary group ID of that user in <code>fsGroup</code>.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--containerSecurityContext--privileged">
              <div style="max-width: 250px;"><a href="./values.yaml#L661">ceemsExporter.containerSecurityContext.privileged</a></div>
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
CEEMS components are capability aware which means they drop all the unnecessary privileges based on runtime configuration. It is important to start pods always with privileges as exporter needs privileges for few collectors.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--containerSecurityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L663">ceemsExporter.containerSecurityContext.readOnlyRootFilesystem</a></div>
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
Important to make root FS writable to add ACL to necessary files.
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--hostNetwork">
              <div style="max-width: 250px;"><a href="./values.yaml#L669">ceemsExporter.hostNetwork</a></div>
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
			<td id="ceemsExporter--hostPID">
              <div style="max-width: 250px;"><a href="./values.yaml#L672">ceemsExporter.hostPID</a></div>
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
			<td id="ceemsExporter--hostIPC">
              <div style="max-width: 250px;"><a href="./values.yaml#L675">ceemsExporter.hostIPC</a></div>
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
			<td id="ceemsExporter--hostRootFsMount">
              <div style="max-width: 250px;"><a href="./values.yaml#L678">ceemsExporter.hostRootFsMount</a></div>
            </td>
            <td>
object
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
{
  "enabled": false,
  "mountPropagation": "HostToContainer"
}
</pre>
</div>
			</td>
			<td>
Mount the node's root file system (`/`) at `/host/root` in the container
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--hostRootFsMount--mountPropagation">
              <div style="max-width: 250px;"><a href="./values.yaml#L685">ceemsExporter.hostRootFsMount.mountPropagation</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"HostToContainer"
</pre>
</div>
			</td>
			<td>
Defines how new mounts in existing mounts on the node or in the container are propagated to the container or node, respectively. Possible values are <code>None</code>, <code>HostToContainer</code>, and <code>Bidirectional</code>. If this field is omitted, then None is used. More information on: https://kubernetes.io/docs/concepts/storage/volumes/#mount-propagation
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--hostProcFsMount--mountPropagation">
              <div style="max-width: 250px;"><a href="./values.yaml#L690">ceemsExporter.hostProcFsMount.mountPropagation</a></div>
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
Mount the node's proc file system (`/proc`) at `/host/proc` in the container. Possible values are <code>None</code>, <code>HostToContainer</code>, and <code>Bidirectional</code>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--hostSysFsMount--mountPropagation">
              <div style="max-width: 250px;"><a href="./values.yaml#L695">ceemsExporter.hostSysFsMount.mountPropagation</a></div>
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
Mount the node's sys file system (`/sys`) at `/host/sys` in the container. Possible values are <code>None</code>, <code>HostToContainer</code>, and <code>Bidirectional</code>
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L700">ceemsExporter.affinity</a></div>
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
Assign a group of affinity scheduling rules Affinity for daemon set that run on all the nodes
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L710">ceemsExporter.podAnnotations</a></div>
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
Annotations to be added to ceems exporter pods
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L713">ceemsExporter.podLabels</a></div>
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
Extra labels to add to ceems exporter pods (can be templated)
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--daemonsetAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L716">ceemsExporter.daemonsetAnnotations</a></div>
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
Annotations to be added to ceems exporter daemonset
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L719">ceemsExporter.dnsConfig</a></div>
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
Custom DNS configuration to be added to ceems-exporter pods
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L732">ceemsExporter.nodeSelector</a></div>
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
			<td id="ceemsExporter--terminationGracePeriodSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L737">ceemsExporter.terminationGracePeriodSeconds</a></div>
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
			<td id="ceemsExporter--tolerations[0]--effect">
              <div style="max-width: 250px;"><a href="./values.yaml#L740">ceemsExporter.tolerations[0].effect</a></div>
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
			<td id="ceemsExporter--tolerations[0]--operator">
              <div style="max-width: 250px;"><a href="./values.yaml#L741">ceemsExporter.tolerations[0].operator</a></div>
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
			<td id="ceemsExporter--terminationMessageParams--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L746">ceemsExporter.terminationMessageParams.enabled</a></div>
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
Enable or disable container termination message settings https://kubernetes.io/docs/tasks/debug/debug-application/determine-reason-pod-failure/
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--terminationMessageParams--terminationMessagePath">
              <div style="max-width: 250px;"><a href="./values.yaml#L748">ceemsExporter.terminationMessageParams.terminationMessagePath</a></div>
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
			<td id="ceemsExporter--terminationMessageParams--terminationMessagePolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L750">ceemsExporter.terminationMessageParams.terminationMessagePolicy</a></div>
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
			<td id="ceemsExporter--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L753">ceemsExporter.priorityClassName</a></div>
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
			<td id="ceemsExporter--extraHostVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L757">ceemsExporter.extraHostVolumeMounts</a></div>
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
Additional mounts from the host to ceems-exporter container
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--configmaps">
              <div style="max-width: 250px;"><a href="./values.yaml#L768">ceemsExporter.configmaps</a></div>
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
			<td id="ceemsExporter--secrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L774">ceemsExporter.secrets</a></div>
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
			<td id="ceemsExporter--extraManifests">
              <div style="max-width: 250px;"><a href="./values.yaml#L779">ceemsExporter.extraManifests</a></div>
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
			<td id="ceemsExporter--extraVolumes">
              <div style="max-width: 250px;"><a href="./values.yaml#L789">ceemsExporter.extraVolumes</a></div>
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
			<td id="ceemsExporter--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L797">ceemsExporter.extraVolumeMounts</a></div>
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
Extra volume mounts in the ceems-exporter container
</td>
		</tr>
		<tr>
			<td id="ceemsExporter--extraInitContainers">
              <div style="max-width: 250px;"><a href="./values.yaml#L804">ceemsExporter.extraInitContainers</a></div>
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
			<td id="ceemsExporter--livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L808">ceemsExporter.livenessProbe</a></div>
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
			<td id="ceemsExporter--readinessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L817">ceemsExporter.readinessProbe</a></div>
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
			<td id="ceemsExporter--version">
              <div style="max-width: 250px;"><a href="./values.yaml#L825">ceemsExporter.version</a></div>
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
		<tr>
			<td id="ceemsAPIServer--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L829">ceemsAPIServer.enabled</a></div>
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
			<td id="ceemsAPIServer--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L831">ceemsAPIServer.imagePullSecrets</a></div>
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
			<td id="ceemsAPIServer--revisionHistoryLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L836">ceemsAPIServer.revisionHistoryLimit</a></div>
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
			<td id="ceemsAPIServer--rbac--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L840">ceemsAPIServer.rbac.create</a></div>
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
			<td id="ceemsAPIServer--rbac--extraClusterRoleRules">
              <div style="max-width: 250px;"><a href="./values.yaml#L842">ceemsAPIServer.rbac.extraClusterRoleRules</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L855">ceemsAPIServer.admissionWebhooks.enabled</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--timeoutSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L857">ceemsAPIServer.admissionWebhooks.timeoutSeconds</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--caBundle">
              <div style="max-width: 250px;"><a href="./values.yaml#L860">ceemsAPIServer.admissionWebhooks.caBundle</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L862">ceemsAPIServer.admissionWebhooks.annotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--mutatingWebhookConfiguration--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L867">ceemsAPIServer.admissionWebhooks.mutatingWebhookConfiguration.annotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--validatingWebhookConfiguration--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L871">ceemsAPIServer.admissionWebhooks.validatingWebhookConfiguration.annotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--replicas">
              <div style="max-width: 250px;"><a href="./values.yaml#L877">ceemsAPIServer.admissionWebhooks.deployment.replicas</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--strategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L881">ceemsAPIServer.admissionWebhooks.deployment.strategy</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--revisionHistoryLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L885">ceemsAPIServer.admissionWebhooks.deployment.revisionHistoryLimit</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L889">ceemsAPIServer.admissionWebhooks.deployment.additionalArgs</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--serviceAccount">
              <div style="max-width: 250px;"><a href="./values.yaml#L894">ceemsAPIServer.admissionWebhooks.deployment.serviceAccount</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--service">
              <div style="max-width: 250px;"><a href="./values.yaml#L902">ceemsAPIServer.admissionWebhooks.deployment.service</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L914">ceemsAPIServer.admissionWebhooks.deployment.service.nodePort</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--service--additionalPorts">
              <div style="max-width: 250px;"><a href="./values.yaml#L919">ceemsAPIServer.admissionWebhooks.deployment.service.additionalPorts</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--service--externalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L923">ceemsAPIServer.admissionWebhooks.deployment.service.externalTrafficPolicy</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L928">ceemsAPIServer.admissionWebhooks.deployment.service.type</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--service--externalIPs">
              <div style="max-width: 250px;"><a href="./values.yaml#L933">ceemsAPIServer.admissionWebhooks.deployment.service.externalIPs</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L937">ceemsAPIServer.admissionWebhooks.deployment.labels</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L941">ceemsAPIServer.admissionWebhooks.deployment.annotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L945">ceemsAPIServer.admissionWebhooks.deployment.podLabels</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L949">ceemsAPIServer.admissionWebhooks.deployment.podAnnotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L952">ceemsAPIServer.admissionWebhooks.deployment.priorityClassName</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L956">ceemsAPIServer.admissionWebhooks.deployment.livenessProbe</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--readinessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L966">ceemsAPIServer.admissionWebhooks.deployment.readinessProbe</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L976">ceemsAPIServer.admissionWebhooks.deployment.resources</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L987">ceemsAPIServer.admissionWebhooks.deployment.nodeSelector</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--tolerations">
              <div style="max-width: 250px;"><a href="./values.yaml#L992">ceemsAPIServer.admissionWebhooks.deployment.tolerations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L1001">ceemsAPIServer.admissionWebhooks.deployment.affinity</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L1012">ceemsAPIServer.admissionWebhooks.deployment.dnsConfig</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--securityContext--fsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L1024">ceemsAPIServer.admissionWebhooks.deployment.securityContext.fsGroup</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L1025">ceemsAPIServer.admissionWebhooks.deployment.securityContext.runAsGroup</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L1026">ceemsAPIServer.admissionWebhooks.deployment.securityContext.runAsNonRoot</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L1027">ceemsAPIServer.admissionWebhooks.deployment.securityContext.runAsUser</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--securityContext--seccompProfile--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L1029">ceemsAPIServer.admissionWebhooks.deployment.securityContext.seccompProfile.type</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--containerSecurityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L1034">ceemsAPIServer.admissionWebhooks.deployment.containerSecurityContext</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--deployment--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L1043">ceemsAPIServer.admissionWebhooks.deployment.automountServiceAccountToken</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1047">ceemsAPIServer.admissionWebhooks.patch.enabled</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L1049">ceemsAPIServer.admissionWebhooks.patch.image.registry</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--image--repository">
              <div style="max-width: 250px;"><a href="./values.yaml#L1050">ceemsAPIServer.admissionWebhooks.patch.image.repository</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L1051">ceemsAPIServer.admissionWebhooks.patch.image.tag</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"v1.6.7"
</pre>
</div>
			</td>
			<td>

</td>
		</tr>
		<tr>
			<td id="ceemsAPIServer--admissionWebhooks--patch--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L1052">ceemsAPIServer.admissionWebhooks.patch.image.sha</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--image--pullPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1053">ceemsAPIServer.admissionWebhooks.patch.image.pullPolicy</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L1054">ceemsAPIServer.admissionWebhooks.patch.resources</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1057">ceemsAPIServer.admissionWebhooks.patch.priorityClassName</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--ttlSecondsAfterFinished">
              <div style="max-width: 250px;"><a href="./values.yaml#L1058">ceemsAPIServer.admissionWebhooks.patch.ttlSecondsAfterFinished</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1059">ceemsAPIServer.admissionWebhooks.patch.annotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1062">ceemsAPIServer.admissionWebhooks.patch.podAnnotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L1063">ceemsAPIServer.admissionWebhooks.patch.nodeSelector</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L1064">ceemsAPIServer.admissionWebhooks.patch.affinity</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--tolerations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1065">ceemsAPIServer.admissionWebhooks.patch.tolerations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L1072">ceemsAPIServer.admissionWebhooks.patch.securityContext.runAsGroup</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L1073">ceemsAPIServer.admissionWebhooks.patch.securityContext.runAsNonRoot</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L1074">ceemsAPIServer.admissionWebhooks.patch.securityContext.runAsUser</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--securityContext--seccompProfile--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L1076">ceemsAPIServer.admissionWebhooks.patch.securityContext.seccompProfile.type</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L1081">ceemsAPIServer.admissionWebhooks.patch.serviceAccount.create</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1082">ceemsAPIServer.admissionWebhooks.patch.serviceAccount.annotations</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patch--serviceAccount--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L1083">ceemsAPIServer.admissionWebhooks.patch.serviceAccount.automountServiceAccountToken</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--createSecretJob--securityContext--allowPrivilegeEscalation">
              <div style="max-width: 250px;"><a href="./values.yaml#L1088">ceemsAPIServer.admissionWebhooks.createSecretJob.securityContext.allowPrivilegeEscalation</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--createSecretJob--securityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1089">ceemsAPIServer.admissionWebhooks.createSecretJob.securityContext.readOnlyRootFilesystem</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--createSecretJob--securityContext--capabilities--drop[0]">
              <div style="max-width: 250px;"><a href="./values.yaml#L1092">ceemsAPIServer.admissionWebhooks.createSecretJob.securityContext.capabilities.drop[0]</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patchWebhookJob--securityContext--allowPrivilegeEscalation">
              <div style="max-width: 250px;"><a href="./values.yaml#L1097">ceemsAPIServer.admissionWebhooks.patchWebhookJob.securityContext.allowPrivilegeEscalation</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patchWebhookJob--securityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1098">ceemsAPIServer.admissionWebhooks.patchWebhookJob.securityContext.readOnlyRootFilesystem</a></div>
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
			<td id="ceemsAPIServer--admissionWebhooks--patchWebhookJob--securityContext--capabilities--drop[0]">
              <div style="max-width: 250px;"><a href="./values.yaml#L1101">ceemsAPIServer.admissionWebhooks.patchWebhookJob.securityContext.capabilities.drop[0]</a></div>
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
			<td id="ceemsAPIServer--dataConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L1106">ceemsAPIServer.dataConfig</a></div>
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
			<td id="ceemsAPIServer--adminConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L1114">ceemsAPIServer.adminConfig</a></div>
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
			<td id="ceemsAPIServer--clusters">
              <div style="max-width: 250px;"><a href="./values.yaml#L1124">ceemsAPIServer.clusters</a></div>
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
			<td id="ceemsAPIServer--updaters">
              <div style="max-width: 250px;"><a href="./values.yaml#L1129">ceemsAPIServer.updaters</a></div>
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
			<td id="ceemsAPIServer--webConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L1133">ceemsAPIServer.webConfig</a></div>
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
			<td id="ceemsAPIServer--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L1148">ceemsAPIServer.additionalArgs</a></div>
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
			<td id="ceemsAPIServer--grafana--datasource--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L1158">ceemsAPIServer.grafana.datasource.create</a></div>
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
			<td id="ceemsAPIServer--grafana--datasource--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L1161">ceemsAPIServer.grafana.datasource.scheme</a></div>
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
			<td id="ceemsAPIServer--grafana--datasource--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L1174">ceemsAPIServer.grafana.datasource.basicAuth</a></div>
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
			<td id="ceemsAPIServer--grafana--datasource--authHeader">
              <div style="max-width: 250px;"><a href="./values.yaml#L1187">ceemsAPIServer.grafana.datasource.authHeader</a></div>
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
			<td id="ceemsAPIServer--grafana--datasource--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L1204">ceemsAPIServer.grafana.datasource.tls</a></div>
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
			<td id="ceemsAPIServer--grafana--dashboards--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L1210">ceemsAPIServer.grafana.dashboards.create</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1216">ceemsAPIServer.kubeRBACProxy.enabled</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L1218">ceemsAPIServer.kubeRBACProxy.env</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L1222">ceemsAPIServer.kubeRBACProxy.image.registry</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--image--repository">
              <div style="max-width: 250px;"><a href="./values.yaml#L1223">ceemsAPIServer.kubeRBACProxy.image.repository</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L1224">ceemsAPIServer.kubeRBACProxy.image.tag</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L1225">ceemsAPIServer.kubeRBACProxy.image.sha</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--image--pullPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1226">ceemsAPIServer.kubeRBACProxy.image.pullPolicy</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L1243">ceemsAPIServer.kubeRBACProxy.additionalArgs</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--containerSecurityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L1248">ceemsAPIServer.kubeRBACProxy.containerSecurityContext</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L1253">ceemsAPIServer.kubeRBACProxy.port</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1255">ceemsAPIServer.kubeRBACProxy.portName</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--enableHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1257">ceemsAPIServer.kubeRBACProxy.enableHostPort</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--proxyEndpointsPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1261">ceemsAPIServer.kubeRBACProxy.proxyEndpointsPort</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--enableProxyEndpointsHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1263">ceemsAPIServer.kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L1268">ceemsAPIServer.kubeRBACProxy.resources</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L1279">ceemsAPIServer.kubeRBACProxy.extraVolumeMounts</a></div>
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
			<td id="ceemsAPIServer--kubeRBACProxy--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L1287">ceemsAPIServer.kubeRBACProxy.tls</a></div>
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
			<td id="ceemsAPIServer--tlsSecret--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1296">ceemsAPIServer.tlsSecret.enabled</a></div>
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
			<td id="ceemsAPIServer--tlsSecret--caItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1298">ceemsAPIServer.tlsSecret.caItem</a></div>
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
			<td id="ceemsAPIServer--tlsSecret--certItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1300">ceemsAPIServer.tlsSecret.certItem</a></div>
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
			<td id="ceemsAPIServer--tlsSecret--keyItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1302">ceemsAPIServer.tlsSecret.keyItem</a></div>
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
			<td id="ceemsAPIServer--tlsSecret--secretName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1304">ceemsAPIServer.tlsSecret.secretName</a></div>
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
			<td id="ceemsAPIServer--tlsSecret--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1306">ceemsAPIServer.tlsSecret.volumeName</a></div>
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
			<td id="ceemsAPIServer--service--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1311">ceemsAPIServer.service.enabled</a></div>
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
			<td id="ceemsAPIServer--service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L1314">ceemsAPIServer.service.type</a></div>
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
			<td id="ceemsAPIServer--service--clusterIP">
              <div style="max-width: 250px;"><a href="./values.yaml#L1316">ceemsAPIServer.service.clusterIP</a></div>
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
			<td id="ceemsAPIServer--service--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L1319">ceemsAPIServer.service.port</a></div>
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
			<td id="ceemsAPIServer--service--servicePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1322">ceemsAPIServer.service.servicePort</a></div>
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
			<td id="ceemsAPIServer--service--targetPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1324">ceemsAPIServer.service.targetPort</a></div>
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
			<td id="ceemsAPIServer--service--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1326">ceemsAPIServer.service.portName</a></div>
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
			<td id="ceemsAPIServer--service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1328">ceemsAPIServer.service.nodePort</a></div>
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
			<td id="ceemsAPIServer--service--listenOnAllInterfaces">
              <div style="max-width: 250px;"><a href="./values.yaml#L1331">ceemsAPIServer.service.listenOnAllInterfaces</a></div>
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
			<td id="ceemsAPIServer--service--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1334">ceemsAPIServer.service.annotations</a></div>
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
			<td id="ceemsAPIServer--service--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L1335">ceemsAPIServer.service.labels</a></div>
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
			<td id="ceemsAPIServer--service--ipDualStack">
              <div style="max-width: 250px;"><a href="./values.yaml#L1339">ceemsAPIServer.service.ipDualStack</a></div>
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
			<td id="ceemsAPIServer--service--externalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1346">ceemsAPIServer.service.externalTrafficPolicy</a></div>
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
			<td id="ceemsAPIServer--service--internalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1349">ceemsAPIServer.service.internalTrafficPolicy</a></div>
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
			<td id="ceemsAPIServer--networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1353">ceemsAPIServer.networkPolicy</a></div>
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
			<td id="ceemsAPIServer--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L1363">ceemsAPIServer.env</a></div>
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
			<td id="ceemsAPIServer--updateStrategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1368">ceemsAPIServer.updateStrategy</a></div>
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
			<td id="ceemsAPIServer--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L1376">ceemsAPIServer.resources</a></div>
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
			<td id="ceemsAPIServer--persistence--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1391">ceemsAPIServer.persistence.enabled</a></div>
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
			<td id="ceemsAPIServer--persistence--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L1393">ceemsAPIServer.persistence.type</a></div>
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
			<td id="ceemsAPIServer--persistence--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1396">ceemsAPIServer.persistence.volumeName</a></div>
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
			<td id="ceemsAPIServer--persistence--accessModes">
              <div style="max-width: 250px;"><a href="./values.yaml#L1398">ceemsAPIServer.persistence.accessModes</a></div>
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
			<td id="ceemsAPIServer--persistence--size">
              <div style="max-width: 250px;"><a href="./values.yaml#L1401">ceemsAPIServer.persistence.size</a></div>
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
			<td id="ceemsAPIServer--persistence--finalizers">
              <div style="max-width: 250px;"><a href="./values.yaml#L1403">ceemsAPIServer.persistence.finalizers</a></div>
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
			<td id="ceemsAPIServer--persistence--extraPvcLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L1411">ceemsAPIServer.persistence.extraPvcLabels</a></div>
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
			<td id="ceemsAPIServer--persistence--disableWarning">
              <div style="max-width: 250px;"><a href="./values.yaml#L1412">ceemsAPIServer.persistence.disableWarning</a></div>
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
			<td id="ceemsAPIServer--persistence--inMemory">
              <div style="max-width: 250px;"><a href="./values.yaml#L1417">ceemsAPIServer.persistence.inMemory</a></div>
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
			<td id="ceemsAPIServer--persistence--lookupVolumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1427">ceemsAPIServer.persistence.lookupVolumeName</a></div>
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
			<td id="ceemsAPIServer--restartPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1431">ceemsAPIServer.restartPolicy</a></div>
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
			<td id="ceemsAPIServer--serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L1435">ceemsAPIServer.serviceAccount.create</a></div>
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
			<td id="ceemsAPIServer--serviceAccount--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L1438">ceemsAPIServer.serviceAccount.name</a></div>
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
			<td id="ceemsAPIServer--serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1439">ceemsAPIServer.serviceAccount.annotations</a></div>
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
			<td id="ceemsAPIServer--serviceAccount--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L1440">ceemsAPIServer.serviceAccount.imagePullSecrets</a></div>
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
			<td id="ceemsAPIServer--serviceAccount--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L1441">ceemsAPIServer.serviceAccount.automountServiceAccountToken</a></div>
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
			<td id="ceemsAPIServer--securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L1444">ceemsAPIServer.securityContext.runAsNonRoot</a></div>
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
			<td id="ceemsAPIServer--securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L1445">ceemsAPIServer.securityContext.runAsUser</a></div>
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
			<td id="ceemsAPIServer--securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L1446">ceemsAPIServer.securityContext.runAsGroup</a></div>
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
			<td id="ceemsAPIServer--containerSecurityContext--privileged">
              <div style="max-width: 250px;"><a href="./values.yaml#L1449">ceemsAPIServer.containerSecurityContext.privileged</a></div>
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
			<td id="ceemsAPIServer--containerSecurityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1450">ceemsAPIServer.containerSecurityContext.readOnlyRootFilesystem</a></div>
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
			<td id="ceemsAPIServer--hostNetwork">
              <div style="max-width: 250px;"><a href="./values.yaml#L1456">ceemsAPIServer.hostNetwork</a></div>
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
			<td id="ceemsAPIServer--hostPID">
              <div style="max-width: 250px;"><a href="./values.yaml#L1459">ceemsAPIServer.hostPID</a></div>
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
			<td id="ceemsAPIServer--hostIPC">
              <div style="max-width: 250px;"><a href="./values.yaml#L1462">ceemsAPIServer.hostIPC</a></div>
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
			<td id="ceemsAPIServer--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L1466">ceemsAPIServer.affinity</a></div>
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
			<td id="ceemsAPIServer--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1477">ceemsAPIServer.podAnnotations</a></div>
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
			<td id="ceemsAPIServer--podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L1480">ceemsAPIServer.podLabels</a></div>
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
			<td id="ceemsAPIServer--deployAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1483">ceemsAPIServer.deployAnnotations</a></div>
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
			<td id="ceemsAPIServer--dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L1486">ceemsAPIServer.dnsConfig</a></div>
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
			<td id="ceemsAPIServer--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L1499">ceemsAPIServer.nodeSelector</a></div>
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
			<td id="ceemsAPIServer--terminationGracePeriodSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L1504">ceemsAPIServer.terminationGracePeriodSeconds</a></div>
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
			<td id="ceemsAPIServer--tolerations[0]--effect">
              <div style="max-width: 250px;"><a href="./values.yaml#L1507">ceemsAPIServer.tolerations[0].effect</a></div>
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
			<td id="ceemsAPIServer--tolerations[0]--operator">
              <div style="max-width: 250px;"><a href="./values.yaml#L1508">ceemsAPIServer.tolerations[0].operator</a></div>
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
			<td id="ceemsAPIServer--terminationMessageParams">
              <div style="max-width: 250px;"><a href="./values.yaml#L1512">ceemsAPIServer.terminationMessageParams</a></div>
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
			<td id="ceemsAPIServer--terminationMessageParams--terminationMessagePath">
              <div style="max-width: 250px;"><a href="./values.yaml#L1515">ceemsAPIServer.terminationMessageParams.terminationMessagePath</a></div>
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
			<td id="ceemsAPIServer--terminationMessageParams--terminationMessagePolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1517">ceemsAPIServer.terminationMessageParams.terminationMessagePolicy</a></div>
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
			<td id="ceemsAPIServer--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1520">ceemsAPIServer.priorityClassName</a></div>
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
			<td id="ceemsAPIServer--extraHostVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L1524">ceemsAPIServer.extraHostVolumeMounts</a></div>
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
			<td id="ceemsAPIServer--configmaps">
              <div style="max-width: 250px;"><a href="./values.yaml#L1535">ceemsAPIServer.configmaps</a></div>
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
			<td id="ceemsAPIServer--secrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L1541">ceemsAPIServer.secrets</a></div>
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
			<td id="ceemsAPIServer--extraInitContainers">
              <div style="max-width: 250px;"><a href="./values.yaml#L1547">ceemsAPIServer.extraInitContainers</a></div>
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
			<td id="ceemsAPIServer--extraManifests">
              <div style="max-width: 250px;"><a href="./values.yaml#L1550">ceemsAPIServer.extraManifests</a></div>
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
			<td id="ceemsAPIServer--extraVolumes">
              <div style="max-width: 250px;"><a href="./values.yaml#L1560">ceemsAPIServer.extraVolumes</a></div>
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
			<td id="ceemsAPIServer--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L1568">ceemsAPIServer.extraVolumeMounts</a></div>
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
			<td id="ceemsAPIServer--livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L1575">ceemsAPIServer.livenessProbe</a></div>
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
			<td id="ceemsAPIServer--readinessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L1584">ceemsAPIServer.readinessProbe</a></div>
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
			<td id="ceemsAPIServer--version">
              <div style="max-width: 250px;"><a href="./values.yaml#L1592">ceemsAPIServer.version</a></div>
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
		<tr>
			<td id="ceemsLB--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1596">ceemsLB.enabled</a></div>
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
			<td id="ceemsLB--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L1598">ceemsLB.imagePullSecrets</a></div>
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
			<td id="ceemsLB--revisionHistoryLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L1603">ceemsLB.revisionHistoryLimit</a></div>
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
			<td id="ceemsLB--rbac--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L1608">ceemsLB.rbac.create</a></div>
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
			<td id="ceemsLB--rbac--extraClusterRoleRules">
              <div style="max-width: 250px;"><a href="./values.yaml#L1610">ceemsLB.rbac.extraClusterRoleRules</a></div>
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
			<td id="ceemsLB--config">
              <div style="max-width: 250px;"><a href="./values.yaml#L1618">ceemsLB.config</a></div>
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
			<td id="ceemsLB--ceemsAPIServer">
              <div style="max-width: 250px;"><a href="./values.yaml#L1624">ceemsLB.ceemsAPIServer</a></div>
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
			<td id="ceemsLB--ceemsAPIServer--persistenceVolumeClaim">
              <div style="max-width: 250px;"><a href="./values.yaml#L1630">ceemsLB.ceemsAPIServer.persistenceVolumeClaim</a></div>
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
			<td id="ceemsLB--ceemsAPIServer--web">
              <div style="max-width: 250px;"><a href="./values.yaml#L1636">ceemsLB.ceemsAPIServer.web</a></div>
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
			<td id="ceemsLB--webConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L1640">ceemsLB.webConfig</a></div>
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
			<td id="ceemsLB--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L1655">ceemsLB.additionalArgs</a></div>
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
			<td id="ceemsLB--grafana--datasource--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L1664">ceemsLB.grafana.datasource.create</a></div>
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
			<td id="ceemsLB--grafana--datasource--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L1667">ceemsLB.grafana.datasource.scheme</a></div>
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
			<td id="ceemsLB--grafana--datasource--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L1681">ceemsLB.grafana.datasource.basicAuth</a></div>
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
			<td id="ceemsLB--grafana--datasource--authHeader">
              <div style="max-width: 250px;"><a href="./values.yaml#L1695">ceemsLB.grafana.datasource.authHeader</a></div>
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
			<td id="ceemsLB--grafana--datasource--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L1713">ceemsLB.grafana.datasource.tls</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1721">ceemsLB.kubeRBACProxy.enabled</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L1723">ceemsLB.kubeRBACProxy.env</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L1727">ceemsLB.kubeRBACProxy.image.registry</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--image--repository">
              <div style="max-width: 250px;"><a href="./values.yaml#L1728">ceemsLB.kubeRBACProxy.image.repository</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L1729">ceemsLB.kubeRBACProxy.image.tag</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L1730">ceemsLB.kubeRBACProxy.image.sha</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--image--pullPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1731">ceemsLB.kubeRBACProxy.image.pullPolicy</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L1748">ceemsLB.kubeRBACProxy.additionalArgs</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--containerSecurityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L1753">ceemsLB.kubeRBACProxy.containerSecurityContext</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L1758">ceemsLB.kubeRBACProxy.port</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1760">ceemsLB.kubeRBACProxy.portName</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--enableHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1762">ceemsLB.kubeRBACProxy.enableHostPort</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--proxyEndpointsPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1766">ceemsLB.kubeRBACProxy.proxyEndpointsPort</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--enableProxyEndpointsHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1768">ceemsLB.kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L1773">ceemsLB.kubeRBACProxy.resources</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L1784">ceemsLB.kubeRBACProxy.extraVolumeMounts</a></div>
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
			<td id="ceemsLB--kubeRBACProxy--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L1792">ceemsLB.kubeRBACProxy.tls</a></div>
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
			<td id="ceemsLB--tlsSecret--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1801">ceemsLB.tlsSecret.enabled</a></div>
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
			<td id="ceemsLB--tlsSecret--caItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1803">ceemsLB.tlsSecret.caItem</a></div>
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
			<td id="ceemsLB--tlsSecret--certItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1805">ceemsLB.tlsSecret.certItem</a></div>
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
			<td id="ceemsLB--tlsSecret--keyItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1807">ceemsLB.tlsSecret.keyItem</a></div>
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
			<td id="ceemsLB--tlsSecret--secretName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1809">ceemsLB.tlsSecret.secretName</a></div>
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
			<td id="ceemsLB--tlsSecret--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1811">ceemsLB.tlsSecret.volumeName</a></div>
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
			<td id="ceemsLB--service--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L1822">ceemsLB.service.enabled</a></div>
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
			<td id="ceemsLB--service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L1825">ceemsLB.service.type</a></div>
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
			<td id="ceemsLB--service--clusterIP">
              <div style="max-width: 250px;"><a href="./values.yaml#L1827">ceemsLB.service.clusterIP</a></div>
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
			<td id="ceemsLB--service--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L1830">ceemsLB.service.port</a></div>
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
			<td id="ceemsLB--service--servicePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1833">ceemsLB.service.servicePort</a></div>
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
			<td id="ceemsLB--service--targetPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1835">ceemsLB.service.targetPort</a></div>
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
			<td id="ceemsLB--service--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1837">ceemsLB.service.portName</a></div>
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
			<td id="ceemsLB--service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L1839">ceemsLB.service.nodePort</a></div>
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
			<td id="ceemsLB--service--listenOnAllInterfaces">
              <div style="max-width: 250px;"><a href="./values.yaml#L1842">ceemsLB.service.listenOnAllInterfaces</a></div>
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
			<td id="ceemsLB--service--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1845">ceemsLB.service.annotations</a></div>
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
			<td id="ceemsLB--service--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L1846">ceemsLB.service.labels</a></div>
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
			<td id="ceemsLB--service--ipDualStack">
              <div style="max-width: 250px;"><a href="./values.yaml#L1850">ceemsLB.service.ipDualStack</a></div>
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
			<td id="ceemsLB--service--externalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1857">ceemsLB.service.externalTrafficPolicy</a></div>
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
			<td id="ceemsLB--service--internalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1860">ceemsLB.service.internalTrafficPolicy</a></div>
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
			<td id="ceemsLB--networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1864">ceemsLB.networkPolicy</a></div>
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
			<td id="ceemsLB--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L1874">ceemsLB.env</a></div>
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
			<td id="ceemsLB--updateStrategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1879">ceemsLB.updateStrategy</a></div>
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
			<td id="ceemsLB--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L1887">ceemsLB.resources</a></div>
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
			<td id="ceemsLB--restartPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L1899">ceemsLB.restartPolicy</a></div>
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
			<td id="ceemsLB--serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L1903">ceemsLB.serviceAccount.create</a></div>
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
			<td id="ceemsLB--serviceAccount--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L1906">ceemsLB.serviceAccount.name</a></div>
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
			<td id="ceemsLB--serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1907">ceemsLB.serviceAccount.annotations</a></div>
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
			<td id="ceemsLB--serviceAccount--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L1908">ceemsLB.serviceAccount.imagePullSecrets</a></div>
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
			<td id="ceemsLB--serviceAccount--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L1909">ceemsLB.serviceAccount.automountServiceAccountToken</a></div>
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
			<td id="ceemsLB--securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L1912">ceemsLB.securityContext.runAsGroup</a></div>
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
			<td id="ceemsLB--securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L1913">ceemsLB.securityContext.runAsNonRoot</a></div>
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
			<td id="ceemsLB--securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L1914">ceemsLB.securityContext.runAsUser</a></div>
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
			<td id="ceemsLB--containerSecurityContext--privileged">
              <div style="max-width: 250px;"><a href="./values.yaml#L1917">ceemsLB.containerSecurityContext.privileged</a></div>
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
			<td id="ceemsLB--containerSecurityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L1918">ceemsLB.containerSecurityContext.readOnlyRootFilesystem</a></div>
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
			<td id="ceemsLB--containerSecurityContext--allowPrivilegeEscalation">
              <div style="max-width: 250px;"><a href="./values.yaml#L1919">ceemsLB.containerSecurityContext.allowPrivilegeEscalation</a></div>
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
			<td id="ceemsLB--hostNetwork">
              <div style="max-width: 250px;"><a href="./values.yaml#L1925">ceemsLB.hostNetwork</a></div>
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
			<td id="ceemsLB--hostPID">
              <div style="max-width: 250px;"><a href="./values.yaml#L1928">ceemsLB.hostPID</a></div>
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
			<td id="ceemsLB--hostIPC">
              <div style="max-width: 250px;"><a href="./values.yaml#L1931">ceemsLB.hostIPC</a></div>
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
			<td id="ceemsLB--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L1935">ceemsLB.affinity</a></div>
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
			<td id="ceemsLB--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1946">ceemsLB.podAnnotations</a></div>
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
			<td id="ceemsLB--podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L1949">ceemsLB.podLabels</a></div>
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
			<td id="ceemsLB--deployAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L1952">ceemsLB.deployAnnotations</a></div>
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
			<td id="ceemsLB--dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L1955">ceemsLB.dnsConfig</a></div>
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
			<td id="ceemsLB--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L1968">ceemsLB.nodeSelector</a></div>
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
			<td id="ceemsLB--terminationGracePeriodSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L1973">ceemsLB.terminationGracePeriodSeconds</a></div>
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
			<td id="ceemsLB--tolerations[0]--effect">
              <div style="max-width: 250px;"><a href="./values.yaml#L1976">ceemsLB.tolerations[0].effect</a></div>
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
			<td id="ceemsLB--tolerations[0]--operator">
              <div style="max-width: 250px;"><a href="./values.yaml#L1977">ceemsLB.tolerations[0].operator</a></div>
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
			<td id="ceemsLB--terminationMessageParams">
              <div style="max-width: 250px;"><a href="./values.yaml#L1981">ceemsLB.terminationMessageParams</a></div>
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
			<td id="ceemsLB--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L1989">ceemsLB.priorityClassName</a></div>
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
			<td id="ceemsLB--extraHostVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L1993">ceemsLB.extraHostVolumeMounts</a></div>
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
			<td id="ceemsLB--configmaps">
              <div style="max-width: 250px;"><a href="./values.yaml#L2004">ceemsLB.configmaps</a></div>
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
			<td id="ceemsLB--secrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L2010">ceemsLB.secrets</a></div>
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
			<td id="ceemsLB--extraInitContainers">
              <div style="max-width: 250px;"><a href="./values.yaml#L2016">ceemsLB.extraInitContainers</a></div>
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
			<td id="ceemsLB--extraManifests">
              <div style="max-width: 250px;"><a href="./values.yaml#L2019">ceemsLB.extraManifests</a></div>
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
			<td id="ceemsLB--extraVolumes">
              <div style="max-width: 250px;"><a href="./values.yaml#L2029">ceemsLB.extraVolumes</a></div>
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
			<td id="ceemsLB--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L2037">ceemsLB.extraVolumeMounts</a></div>
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
			<td id="ceemsLB--livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L2044">ceemsLB.livenessProbe</a></div>
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
			<td id="ceemsLB--readinessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L2053">ceemsLB.readinessProbe</a></div>
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
			<td id="ceemsLB--version">
              <div style="max-width: 250px;"><a href="./values.yaml#L2061">ceemsLB.version</a></div>
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
		<tr>
			<td id="redfishProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L2065">redfishProxy.enabled</a></div>
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
Deploys redfish proxy
</td>
		</tr>
		<tr>
			<td id="redfishProxy--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L2067">redfishProxy.imagePullSecrets</a></div>
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
			<td id="redfishProxy--revisionHistoryLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L2072">redfishProxy.revisionHistoryLimit</a></div>
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
			<td id="redfishProxy--rbac--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L2077">redfishProxy.rbac.create</a></div>
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
			<td id="redfishProxy--rbac--extraClusterRoleRules">
              <div style="max-width: 250px;"><a href="./values.yaml#L2079">redfishProxy.rbac.extraClusterRoleRules</a></div>
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
Any extra cluster roles to be added to redfish proxy.
</td>
		</tr>
		<tr>
			<td id="redfishProxy--insecureSkipVerify">
              <div style="max-width: 250px;"><a href="./values.yaml#L2086">redfishProxy.insecureSkipVerify</a></div>
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
If redfish target servers are using self signed TLS certificates, set it to true to skip TLS verfication
</td>
		</tr>
		<tr>
			<td id="redfishProxy--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L2101">redfishProxy.additionalArgs</a></div>
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
Additional arguments for redfish proxy List of dicts with <code>name</code> and <code>value</code> fields. <code>value</code> field can be empty for name only arguments. For e.g., for `--log.level=debug` set the following

```yaml
additionalArgs:
  - name: log.level
    value: debug
```

</td>
		</tr>
		<tr>
			<td id="redfishProxy--kubeRBACProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L2109">redfishProxy.kubeRBACProxy.enabled</a></div>
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
When enabled, creates a kube-rbac-proxy to protect the redfish proxy and redfish proxy http endpoint. The requests are served through the same service but requests are HTTPS.
</td>
		</tr>
		<tr>
			<td id="redfishProxy--kubeRBACProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L2111">redfishProxy.kubeRBACProxy.env</a></div>
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
Set environment variables as name/value pairs
</td>
		</tr>
		<tr>
			<td id="redfishProxy--kubeRBACProxy--image--registry">
              <div style="max-width: 250px;"><a href="./values.yaml#L2115">redfishProxy.kubeRBACProxy.image.registry</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--image--repository">
              <div style="max-width: 250px;"><a href="./values.yaml#L2116">redfishProxy.kubeRBACProxy.image.repository</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--image--tag">
              <div style="max-width: 250px;"><a href="./values.yaml#L2117">redfishProxy.kubeRBACProxy.image.tag</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--image--sha">
              <div style="max-width: 250px;"><a href="./values.yaml#L2118">redfishProxy.kubeRBACProxy.image.sha</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--image--pullPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L2119">redfishProxy.kubeRBACProxy.image.pullPolicy</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L2136">redfishProxy.kubeRBACProxy.additionalArgs</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--containerSecurityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L2141">redfishProxy.kubeRBACProxy.containerSecurityContext</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L2146">redfishProxy.kubeRBACProxy.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
4000
</pre>
</div>
			</td>
			<td>
Specify the port used for the redfish proxy container (upstream port)
</td>
		</tr>
		<tr>
			<td id="redfishProxy--kubeRBACProxy--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L2148">redfishProxy.kubeRBACProxy.portName</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--enableHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L2150">redfishProxy.kubeRBACProxy.enableHostPort</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--proxyEndpointsPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L2154">redfishProxy.kubeRBACProxy.proxyEndpointsPort</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--enableProxyEndpointsHostPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L2156">redfishProxy.kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L2161">redfishProxy.kubeRBACProxy.resources</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L2172">redfishProxy.kubeRBACProxy.extraVolumeMounts</a></div>
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
			<td id="redfishProxy--kubeRBACProxy--tls">
              <div style="max-width: 250px;"><a href="./values.yaml#L2180">redfishProxy.kubeRBACProxy.tls</a></div>
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
Enables using TLS resources from a volume on secret referred to in <code>tlsSecret</code> below. When enabling <code>tlsClientAuth</code>, client CA certificate must be set in `tlsSecret.caItem`. Ref. https://github.com/brancz/kube-rbac-proxy/issues/187
</td>
		</tr>
		<tr>
			<td id="redfishProxy--tlsSecret--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L2189">redfishProxy.tlsSecret.enabled</a></div>
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
			<td id="redfishProxy--tlsSecret--caItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L2191">redfishProxy.tlsSecret.caItem</a></div>
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
			<td id="redfishProxy--tlsSecret--certItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L2193">redfishProxy.tlsSecret.certItem</a></div>
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
			<td id="redfishProxy--tlsSecret--keyItem">
              <div style="max-width: 250px;"><a href="./values.yaml#L2195">redfishProxy.tlsSecret.keyItem</a></div>
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
			<td id="redfishProxy--tlsSecret--secretName">
              <div style="max-width: 250px;"><a href="./values.yaml#L2197">redfishProxy.tlsSecret.secretName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"redfish-proxy-tls"
</pre>
</div>
			</td>
			<td>
Name of an existing secret
</td>
		</tr>
		<tr>
			<td id="redfishProxy--tlsSecret--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L2199">redfishProxy.tlsSecret.volumeName</a></div>
            </td>
            <td>
string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
"redfish-proxy-tls"
</pre>
</div>
			</td>
			<td>
Name of the volume to be created
</td>
		</tr>
		<tr>
			<td id="redfishProxy--service--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L2204">redfishProxy.service.enabled</a></div>
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
			<td id="redfishProxy--service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L2207">redfishProxy.service.type</a></div>
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
			<td id="redfishProxy--service--clusterIP">
              <div style="max-width: 250px;"><a href="./values.yaml#L2209">redfishProxy.service.clusterIP</a></div>
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
			<td id="redfishProxy--service--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L2212">redfishProxy.service.port</a></div>
            </td>
            <td>
int
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
5000
</pre>
</div>
			</td>
			<td>
Default service port. Sets the port of the exposed container as well (NE or kubeRBACProxy). Use <code>servicePort</code> below if changing the service port only is desired.
</td>
		</tr>
		<tr>
			<td id="redfishProxy--service--servicePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L2215">redfishProxy.service.servicePort</a></div>
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
			<td id="redfishProxy--service--targetPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L2217">redfishProxy.service.targetPort</a></div>
            </td>
            <td>
int or string
</td>
			<td>
				<div style="max-width: 250px;">
<pre lang="json">
5000
</pre>
</div>
			</td>
			<td>
Targeted port in the pod. Must refer to an open container port (<code>port</code> or <code>portName</code>).
</td>
		</tr>
		<tr>
			<td id="redfishProxy--service--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L2219">redfishProxy.service.portName</a></div>
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
			<td id="redfishProxy--service--nodePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L2221">redfishProxy.service.nodePort</a></div>
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
Port number for service type NodePort
</td>
		</tr>
		<tr>
			<td id="redfishProxy--service--listenOnAllInterfaces">
              <div style="max-width: 250px;"><a href="./values.yaml#L2224">redfishProxy.service.listenOnAllInterfaces</a></div>
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
If true, redfish proxy will listen on all interfaces
</td>
		</tr>
		<tr>
			<td id="redfishProxy--service--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L2227">redfishProxy.service.annotations</a></div>
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
			<td id="redfishProxy--service--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L2228">redfishProxy.service.labels</a></div>
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
			<td id="redfishProxy--service--ipDualStack">
              <div style="max-width: 250px;"><a href="./values.yaml#L2232">redfishProxy.service.ipDualStack</a></div>
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
			<td id="redfishProxy--service--externalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L2239">redfishProxy.service.externalTrafficPolicy</a></div>
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
			<td id="redfishProxy--service--internalTrafficPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L2242">redfishProxy.service.internalTrafficPolicy</a></div>
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
			<td id="redfishProxy--networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L2246">redfishProxy.networkPolicy</a></div>
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
			<td id="redfishProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L2256">redfishProxy.env</a></div>
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
Additional environment variables that will be passed to the deployment.
</td>
		</tr>
		<tr>
			<td id="redfishProxy--updateStrategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L2261">redfishProxy.updateStrategy</a></div>
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
			<td id="redfishProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L2269">redfishProxy.resources</a></div>
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
			<td id="redfishProxy--restartPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L2281">redfishProxy.restartPolicy</a></div>
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
			<td id="redfishProxy--serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L2285">redfishProxy.serviceAccount.create</a></div>
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
			<td id="redfishProxy--serviceAccount--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L2288">redfishProxy.serviceAccount.name</a></div>
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
			<td id="redfishProxy--serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L2289">redfishProxy.serviceAccount.annotations</a></div>
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
			<td id="redfishProxy--serviceAccount--imagePullSecrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L2290">redfishProxy.serviceAccount.imagePullSecrets</a></div>
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
			<td id="redfishProxy--serviceAccount--automountServiceAccountToken">
              <div style="max-width: 250px;"><a href="./values.yaml#L2291">redfishProxy.serviceAccount.automountServiceAccountToken</a></div>
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
			<td id="redfishProxy--securityContext--runAsGroup">
              <div style="max-width: 250px;"><a href="./values.yaml#L2294">redfishProxy.securityContext.runAsGroup</a></div>
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
			<td id="redfishProxy--securityContext--runAsNonRoot">
              <div style="max-width: 250px;"><a href="./values.yaml#L2295">redfishProxy.securityContext.runAsNonRoot</a></div>
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
			<td id="redfishProxy--securityContext--runAsUser">
              <div style="max-width: 250px;"><a href="./values.yaml#L2296">redfishProxy.securityContext.runAsUser</a></div>
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
			<td id="redfishProxy--containerSecurityContext--privileged">
              <div style="max-width: 250px;"><a href="./values.yaml#L2299">redfishProxy.containerSecurityContext.privileged</a></div>
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
			<td id="redfishProxy--containerSecurityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L2300">redfishProxy.containerSecurityContext.readOnlyRootFilesystem</a></div>
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
			<td id="redfishProxy--containerSecurityContext--allowPrivilegeEscalation">
              <div style="max-width: 250px;"><a href="./values.yaml#L2301">redfishProxy.containerSecurityContext.allowPrivilegeEscalation</a></div>
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
			<td id="redfishProxy--hostNetwork">
              <div style="max-width: 250px;"><a href="./values.yaml#L2307">redfishProxy.hostNetwork</a></div>
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
			<td id="redfishProxy--hostPID">
              <div style="max-width: 250px;"><a href="./values.yaml#L2310">redfishProxy.hostPID</a></div>
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
			<td id="redfishProxy--hostIPC">
              <div style="max-width: 250px;"><a href="./values.yaml#L2313">redfishProxy.hostIPC</a></div>
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
			<td id="redfishProxy--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L2317">redfishProxy.affinity</a></div>
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
			<td id="redfishProxy--podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L2328">redfishProxy.podAnnotations</a></div>
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
Annotations to be added to redfish proxy pods
</td>
		</tr>
		<tr>
			<td id="redfishProxy--podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L2331">redfishProxy.podLabels</a></div>
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
Extra labels to add to redfish proxy pods (can be templated)
</td>
		</tr>
		<tr>
			<td id="redfishProxy--deployAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L2334">redfishProxy.deployAnnotations</a></div>
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
Annotations to be added to redfish proxy deployment
</td>
		</tr>
		<tr>
			<td id="redfishProxy--dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L2337">redfishProxy.dnsConfig</a></div>
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
Custom DNS configuration to be added to redfish proxy pods
</td>
		</tr>
		<tr>
			<td id="redfishProxy--nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L2349">redfishProxy.nodeSelector</a></div>
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
			<td id="redfishProxy--terminationGracePeriodSeconds">
              <div style="max-width: 250px;"><a href="./values.yaml#L2354">redfishProxy.terminationGracePeriodSeconds</a></div>
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
			<td id="redfishProxy--tolerations[0]--effect">
              <div style="max-width: 250px;"><a href="./values.yaml#L2357">redfishProxy.tolerations[0].effect</a></div>
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
			<td id="redfishProxy--tolerations[0]--operator">
              <div style="max-width: 250px;"><a href="./values.yaml#L2358">redfishProxy.tolerations[0].operator</a></div>
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
			<td id="redfishProxy--terminationMessageParams">
              <div style="max-width: 250px;"><a href="./values.yaml#L2362">redfishProxy.terminationMessageParams</a></div>
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
			<td id="redfishProxy--terminationMessageParams--terminationMessagePath">
              <div style="max-width: 250px;"><a href="./values.yaml#L2365">redfishProxy.terminationMessageParams.terminationMessagePath</a></div>
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
			<td id="redfishProxy--terminationMessageParams--terminationMessagePolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L2367">redfishProxy.terminationMessageParams.terminationMessagePolicy</a></div>
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
			<td id="redfishProxy--priorityClassName">
              <div style="max-width: 250px;"><a href="./values.yaml#L2370">redfishProxy.priorityClassName</a></div>
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
			<td id="redfishProxy--extraHostVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L2373">redfishProxy.extraHostVolumeMounts</a></div>
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
Additional mounts from the host to redfish-proxy container
</td>
		</tr>
		<tr>
			<td id="redfishProxy--configmaps">
              <div style="max-width: 250px;"><a href="./values.yaml#L2383">redfishProxy.configmaps</a></div>
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
			<td id="redfishProxy--secrets">
              <div style="max-width: 250px;"><a href="./values.yaml#L2388">redfishProxy.secrets</a></div>
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
			<td id="redfishProxy--extraInitContainers">
              <div style="max-width: 250px;"><a href="./values.yaml#L2393">redfishProxy.extraInitContainers</a></div>
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
			<td id="redfishProxy--extraManifests">
              <div style="max-width: 250px;"><a href="./values.yaml#L2396">redfishProxy.extraManifests</a></div>
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
			<td id="redfishProxy--extraVolumes">
              <div style="max-width: 250px;"><a href="./values.yaml#L2406">redfishProxy.extraVolumes</a></div>
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
			<td id="redfishProxy--extraVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L2414">redfishProxy.extraVolumeMounts</a></div>
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
Extra volume mounts in the redfish-proxy container
</td>
		</tr>
		<tr>
			<td id="redfishProxy--livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L2420">redfishProxy.livenessProbe</a></div>
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
			<td id="redfishProxy--readinessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L2428">redfishProxy.readinessProbe</a></div>
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
			<td id="redfishProxy--version">
              <div style="max-width: 250px;"><a href="./values.yaml#L2436">redfishProxy.version</a></div>
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
		<tr>
			<td id="kubePrometheusStack--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L2440">kubePrometheusStack.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2452">kube-prometheus-stack.fullnameOverride</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2457">kube-prometheus-stack.crds</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2464">kube-prometheus-stack.defaultRules</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2471">kube-prometheus-stack.prometheusOperator.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2476">kube-prometheus-stack.prometheusOperator.namespaces</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2483">kube-prometheus-stack.prometheusOperator.kubeletService.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2487">kube-prometheus-stack.prometheusOperator.kubeletEndpointsEnabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2490">kube-prometheus-stack.prometheusOperator.kubeletEndpointSliceEnabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2494">kube-prometheus-stack.prometheus</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2500">kube-prometheus-stack.grafana.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2505">kube-prometheus-stack.grafana.env</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2510">kube-prometheus-stack.grafana.defaultDashboardsEnabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2513">kube-prometheus-stack.grafana.adminUser</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2516">kube-prometheus-stack.grafana.adminPassword</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2520">kube-prometheus-stack.grafana.plugins</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2524">kube-prometheus-stack.grafana.serviceAccount.create</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2529">kube-prometheus-stack.grafana.sidecar.datasources.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2531">kube-prometheus-stack.grafana.sidecar.datasources.defaultDatasourceEnabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2533">kube-prometheus-stack.grafana.sidecar.datasources.label</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2535">kube-prometheus-stack.grafana.sidecar.datasources.labelValue</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2537">kube-prometheus-stack.grafana.sidecar.datasources.searchNamespace</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2539">kube-prometheus-stack.grafana.sidecar.datasources.name</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2546">kube-prometheus-stack.grafana.sidecar.datasources.env</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2549">kube-prometheus-stack.grafana.sidecar.datasources.alertmanager</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2553">kube-prometheus-stack.grafana.sidecar.dashboards.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2555">kube-prometheus-stack.grafana.sidecar.dashboards.label</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2557">kube-prometheus-stack.grafana.sidecar.dashboards.labelValue</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2559">kube-prometheus-stack.grafana.sidecar.dashboards.searchNamespace</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2561">kube-prometheus-stack.grafana.sidecar.dashboards.folderAnnotation</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2564">kube-prometheus-stack.grafana.sidecar.dashboards.provider</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2566">kube-prometheus-stack.grafana.sidecar.dashboards.provider.name</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2568">kube-prometheus-stack.grafana.sidecar.dashboards.provider.updateIntervalSeconds</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2570">kube-prometheus-stack.grafana.sidecar.dashboards.provider.foldersFromFilesStructure</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2578">kube-prometheus-stack.grafana.sidecar.dashboards.env</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2584">kube-prometheus-stack.grafana.serviceMonitor.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2589">kube-prometheus-stack.extraManifests</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2616">kube-prometheus-stack.thanosRuler</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2622">kube-prometheus-stack.alertmanager</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2627">kube-prometheus-stack.kubernetesServiceMonitors</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2632">kube-prometheus-stack.kubeApiServer</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2637">kube-prometheus-stack.kubelet</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2642">kube-prometheus-stack.kubeControllerManager</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2647">kube-prometheus-stack.coreDns</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2652">kube-prometheus-stack.kubeDns</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2657">kube-prometheus-stack.kubeEtcd</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2662">kube-prometheus-stack.kubeScheduler</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2667">kube-prometheus-stack.kubeProxy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2672">kube-prometheus-stack.kubeStateMetrics</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2677">kube-prometheus-stack.nodeExporter</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2681">pyroscopeServer</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2690">pyroscope.pyroscope.fullnameOverride</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2693">pyroscope.ingress</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2697">pyroscope.alloy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2701">pyroscope.agent</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L2705">pyroscope.minio</a></div>
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

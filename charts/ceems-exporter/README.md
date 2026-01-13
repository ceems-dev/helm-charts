<!-- textlint-disable -->

# ceems-exporter

![Version: 0.2.1](https://img.shields.io/badge/Version-0.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.12.1](https://img.shields.io/badge/AppVersion-0.12.1-informational?style=flat-square)

A Helm chart for deploying CEEMS Exporter

**Homepage:** <https://ceems-dev.github.io/helm-charts/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mahendrapaipuri | <mahendra.paipuri@gmail.com> | <https://github.com/mahendrapaipuri> |

## Source Code

* <https://github.com/ceems-dev/helm-charts>

<!-- textlint-enable -->

## Description

Installs Prometheus exporter component of the [CEEMS](https://ceems-dev.github.io/ceems/docs/), a collection of Kubernetes manifests,
and Prometheus rules combined with documentation and scripts to provide easy to operate end-to-end
Kubernetes cluster energy and emissions monitoring with Prometheus and Grafana.

## Prerequisites

* Kubernetes 1.19+
* Helm 3+

## Usage

The chart is distributed as an [OCI Artifact](https://helm.sh/docs/topics/registries/) as well as via a
traditional [Helm Repository](https://helm.sh/docs/topics/chart_repository/).

* OCI Artifact: `oci://ghcr.io/ceems-dev/charts/ceems-exporter`
* Helm Repository: `https://ceems-dev.github.io/helm-charts` with chart `ceems-exporter`

The installation instructions use the OCI registry. Refer to the [`helm repo`](https://helm.sh/docs/helm/helm_repo/)
command documentation for information on installing charts via the traditional repository.

### Install Helm Chart

```console
helm install -n ceems --create-namespace ceems-exporter oci://ghcr.io/ceems-dev/charts/ceems-exporter
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

### Uninstall Helm Chart

```console
helm uninstall -n ceems ceems-exporter
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

### Upgrading Chart

```console
helm upgrade -n ceems ceems-exporter
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing).
To see all configurable options with detailed comments:

```console
helm show values oci://ghcr.io/ceems-dev/charts/ceems-exporter
```

You may also consult chart's [Values](#values) for detailed description of all values.

Values files in the [ci](./ci) folder can be a good starting point for setting up production
deployments with authentication. Each file shows a different scenario with detailed comments
are provided in the files.

### kube-rbac-proxy

You can enable `ceems-exporter` endpoint protection using `kube-rbac-proxy`. By setting
`kubeRBACProxy.enabled: true`, this chart will deploy a RBAC proxy container protecting the
ceems-exporter endpoint. To authorize access, authenticate your requests
(via a `ServiceAccount` for example) with a `ClusterRole` attached such as:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: ceems-exporter-read
rules:
  - apiGroups: [ "" ]
    resources: ["services/ceems-ceems-exporter"]
    verbs:
      - get
```

See [kube-rbac-proxy examples](https://github.com/brancz/kube-rbac-proxy/tree/master/examples/resource-attributes) for more details.

## Multiple releases

The same chart can be used to run multiple CEEMS exporter instances in the same cluster if required. This makes sense when one control
plane cluster is managing different workload clusters.

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
Provide a name in place of ceems-exporter for `app:` labels
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
Number of old history to retain to allow rollback. Default Kubernetes value is set to 10
</td>
		</tr>
		<tr>
			<td id="rbac">
              <div style="max-width: 250px;"><a href="./values.yaml#L70">rbac</a></div>
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
			<td id="collectors--k8s--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L82">collectors.k8s.enabled</a></div>
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
			<td id="collectors--k8s--kubeletSocketDirectory">
              <div style="max-width: 250px;"><a href="./values.yaml#L84">collectors.k8s.kubeletSocketDirectory</a></div>
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
			<td id="collectors--slurm--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L87">collectors.slurm.enabled</a></div>
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
			<td id="collectors--slurm--configDirectory">
              <div style="max-width: 250px;"><a href="./values.yaml#L90">collectors.slurm.configDirectory</a></div>
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
			<td id="collectors--libvirt--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L93">collectors.libvirt.enabled</a></div>
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
			<td id="collectors--ipmi--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L96">collectors.ipmi.enabled</a></div>
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
			<td id="collectors--ipmi--device">
              <div style="max-width: 250px;"><a href="./values.yaml#L98">collectors.ipmi.device</a></div>
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
			<td id="collectors--ipmi--monitorPowerEnergySensorReadings">
              <div style="max-width: 250px;"><a href="./values.yaml#L100">collectors.ipmi.monitorPowerEnergySensorReadings</a></div>
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
			<td id="collectors--ipmi--monitorSensorIDs">
              <div style="max-width: 250px;"><a href="./values.yaml#L102">collectors.ipmi.monitorSensorIDs</a></div>
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
			<td id="collectors--redfish--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L105">collectors.redfish.enabled</a></div>
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
			<td id="collectors--redfish--chassisNames">
              <div style="max-width: 250px;"><a href="./values.yaml#L107">collectors.redfish.chassisNames</a></div>
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
			<td id="collectors--redfish--config">
              <div style="max-width: 250px;"><a href="./values.yaml#L110">collectors.redfish.config</a></div>
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
			<td id="collectors--redfish--config--external_url">
              <div style="max-width: 250px;"><a href="./values.yaml#L115">collectors.redfish.config.external_url</a></div>
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
			<td id="collectors--hwmon--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L122">collectors.hwmon.enabled</a></div>
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
			<td id="collectors--hwmon--chipNames">
              <div style="max-width: 250px;"><a href="./values.yaml#L124">collectors.hwmon.chipNames</a></div>
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
			<td id="collectors--crayPMC--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L127">collectors.crayPMC.enabled</a></div>
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
			<td id="collectors--rapl--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L130">collectors.rapl.enabled</a></div>
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
			<td id="collectors--emissions--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L140">collectors.emissions.enabled</a></div>
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
			<td id="collectors--emissions--countryCode">
              <div style="max-width: 250px;"><a href="./values.yaml#L146">collectors.emissions.countryCode</a></div>
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
			<td id="collectors--emissions--providers">
              <div style="max-width: 250px;"><a href="./values.yaml#L148">collectors.emissions.providers</a></div>
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
			<td id="collectors--emissions--deploy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L158">collectors.emissions.deploy.env</a></div>
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
			<td id="collectors--emissions--deploy--affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L164">collectors.emissions.deploy.affinity</a></div>
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
			<td id="collectors--emissions--deploy--deploymentAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L173">collectors.emissions.deploy.deploymentAnnotations</a></div>
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
			<td id="collectors--emissions--deploy--networkPolicy">
              <div style="max-width: 250px;"><a href="./values.yaml#L175">collectors.emissions.deploy.networkPolicy</a></div>
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
			<td id="eBPFProfiling--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L186">eBPFProfiling.enabled</a></div>
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
			<td id="eBPFProfiling--config">
              <div style="max-width: 250px;"><a href="./values.yaml#L190">eBPFProfiling.config</a></div>
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
			<td id="webConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L194">webConfig</a></div>
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
			<td id="additionalArgs">
              <div style="max-width: 250px;"><a href="./values.yaml#L212">additionalArgs</a></div>
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
			<td id="kubeRBACProxy--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L221">kubeRBACProxy.enabled</a></div>
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
			<td id="kubeRBACProxy--env">
              <div style="max-width: 250px;"><a href="./values.yaml#L223">kubeRBACProxy.env</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L227">kubeRBACProxy.image.registry</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L228">kubeRBACProxy.image.repository</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L229">kubeRBACProxy.image.tag</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L230">kubeRBACProxy.image.sha</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L231">kubeRBACProxy.image.pullPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L248">kubeRBACProxy.additionalArgs</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L253">kubeRBACProxy.containerSecurityContext</a></div>
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
			<td id="kubeRBACProxy--port">
              <div style="max-width: 250px;"><a href="./values.yaml#L258">kubeRBACProxy.port</a></div>
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
			<td id="kubeRBACProxy--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L260">kubeRBACProxy.portName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L262">kubeRBACProxy.enableHostPort</a></div>
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
			<td id="kubeRBACProxy--proxyEndpointsPort">
              <div style="max-width: 250px;"><a href="./values.yaml#L266">kubeRBACProxy.proxyEndpointsPort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L269">kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
			<td id="kubeRBACProxy--resources">
              <div style="max-width: 250px;"><a href="./values.yaml#L274">kubeRBACProxy.resources</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L285">kubeRBACProxy.extraVolumeMounts</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L293">kubeRBACProxy.tls</a></div>
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
			<td id="tlsSecret--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L302">tlsSecret.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L304">tlsSecret.caItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L306">tlsSecret.certItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L308">tlsSecret.keyItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L310">tlsSecret.secretName</a></div>
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
			<td id="tlsSecret--volumeName">
              <div style="max-width: 250px;"><a href="./values.yaml#L312">tlsSecret.volumeName</a></div>
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
			<td id="service--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L316">service.enabled</a></div>
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
			<td id="service--type">
              <div style="max-width: 250px;"><a href="./values.yaml#L319">service.type</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L321">service.clusterIP</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L324">service.port</a></div>
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
			<td id="service--servicePort">
              <div style="max-width: 250px;"><a href="./values.yaml#L327">service.servicePort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L329">service.targetPort</a></div>
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
			<td id="service--portName">
              <div style="max-width: 250px;"><a href="./values.yaml#L331">service.portName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L333">service.nodePort</a></div>
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
			<td id="service--listenOnAllInterfaces">
              <div style="max-width: 250px;"><a href="./values.yaml#L336">service.listenOnAllInterfaces</a></div>
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
			<td id="service--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L339">service.annotations</a></div>
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
			<td id="service--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L343">service.labels</a></div>
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
			<td id="service--ipDualStack">
              <div style="max-width: 250px;"><a href="./values.yaml#L347">service.ipDualStack</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L354">service.externalTrafficPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L358">service.internalTrafficPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L361">networkPolicy</a></div>
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
			<td id="env">
              <div style="max-width: 250px;"><a href="./values.yaml#L371">env</a></div>
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
			<td id="prometheus--defaultRules--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L384">prometheus.defaultRules.create</a></div>
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
			<td id="prometheus--defaultRules--rules--nvidiaGPU">
              <div style="max-width: 250px;"><a href="./values.yaml#L391">prometheus.defaultRules.rules.nvidiaGPU</a></div>
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
			<td id="prometheus--defaultRules--rules--amdGPU">
              <div style="max-width: 250px;"><a href="./values.yaml#L402">prometheus.defaultRules.rules.amdGPU</a></div>
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
			<td id="prometheus--defaultRules--pue">
              <div style="max-width: 250px;"><a href="./values.yaml#L408">prometheus.defaultRules.pue</a></div>
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
			<td id="prometheus--defaultRules--labels">
              <div style="max-width: 250px;"><a href="./values.yaml#L411">prometheus.defaultRules.labels</a></div>
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
			<td id="prometheus--defaultRules--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L413">prometheus.defaultRules.annotations</a></div>
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
			<td id="prometheus--monitor--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L417">prometheus.monitor.enabled</a></div>
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
			<td id="prometheus--monitor--dcgmExporterEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L420">prometheus.monitor.dcgmExporterEnabled</a></div>
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
			<td id="prometheus--monitor--amdDeviceMetricsExporterEnabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L423">prometheus.monitor.amdDeviceMetricsExporterEnabled</a></div>
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
			<td id="prometheus--monitor--additionalLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L425">prometheus.monitor.additionalLabels</a></div>
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
			<td id="prometheus--monitor--namespace">
              <div style="max-width: 250px;"><a href="./values.yaml#L427">prometheus.monitor.namespace</a></div>
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
			<td id="prometheus--monitor--jobLabel">
              <div style="max-width: 250px;"><a href="./values.yaml#L429">prometheus.monitor.jobLabel</a></div>
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
			<td id="prometheus--monitor--apiVersion">
              <div style="max-width: 250px;"><a href="./values.yaml#L431">prometheus.monitor.apiVersion</a></div>
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
			<td id="prometheus--monitor--podTargetLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L434">prometheus.monitor.podTargetLabels</a></div>
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
			<td id="prometheus--monitor--targetLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L437">prometheus.monitor.targetLabels</a></div>
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
			<td id="prometheus--monitor--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L440">prometheus.monitor.scheme</a></div>
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
			<td id="prometheus--monitor--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L443">prometheus.monitor.basicAuth</a></div>
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
			<td id="prometheus--monitor--tlsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L446">prometheus.monitor.tlsConfig</a></div>
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
			<td id="prometheus--monitor--authorization">
              <div style="max-width: 250px;"><a href="./values.yaml#L449">prometheus.monitor.authorization</a></div>
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
			<td id="prometheus--monitor--oauth2">
              <div style="max-width: 250px;"><a href="./values.yaml#L452">prometheus.monitor.oauth2</a></div>
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
			<td id="prometheus--monitor--proxyUrl">
              <div style="max-width: 250px;"><a href="./values.yaml#L455">prometheus.monitor.proxyUrl</a></div>
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
			<td id="prometheus--monitor--selectorOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L457">prometheus.monitor.selectorOverride</a></div>
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
			<td id="prometheus--monitor--attachMetadata">
              <div style="max-width: 250px;"><a href="./values.yaml#L460">prometheus.monitor.attachMetadata</a></div>
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
			<td id="prometheus--monitor--interval">
              <div style="max-width: 250px;"><a href="./values.yaml#L464">prometheus.monitor.interval</a></div>
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
			<td id="prometheus--monitor--scrapeTimeout">
              <div style="max-width: 250px;"><a href="./values.yaml#L466">prometheus.monitor.scrapeTimeout</a></div>
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
			<td id="prometheus--monitor--honorTimestamps">
              <div style="max-width: 250px;"><a href="./values.yaml#L468">prometheus.monitor.honorTimestamps</a></div>
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
			<td id="prometheus--monitor--honorLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L470">prometheus.monitor.honorLabels</a></div>
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
			<td id="prometheus--monitor--enableHttp2">
              <div style="max-width: 250px;"><a href="./values.yaml#L472">prometheus.monitor.enableHttp2</a></div>
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
			<td id="prometheus--monitor--filterRunning">
              <div style="max-width: 250px;"><a href="./values.yaml#L475">prometheus.monitor.filterRunning</a></div>
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
			<td id="prometheus--monitor--followRedirects">
              <div style="max-width: 250px;"><a href="./values.yaml#L477">prometheus.monitor.followRedirects</a></div>
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
			<td id="prometheus--monitor--params">
              <div style="max-width: 250px;"><a href="./values.yaml#L479">prometheus.monitor.params</a></div>
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
			<td id="prometheus--monitor--relabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L485">prometheus.monitor.relabelings</a></div>
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
			<td id="prometheus--monitor--metricRelabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L487">prometheus.monitor.metricRelabelings</a></div>
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
			<td id="prometheus--monitor--sampleLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L490">prometheus.monitor.sampleLimit</a></div>
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
			<td id="prometheus--monitor--targetLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L492">prometheus.monitor.targetLimit</a></div>
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
			<td id="prometheus--monitor--labelLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L495">prometheus.monitor.labelLimit</a></div>
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
			<td id="prometheus--monitor--labelNameLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L498">prometheus.monitor.labelNameLengthLimit</a></div>
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
			<td id="prometheus--monitor--labelValueLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L501">prometheus.monitor.labelValueLengthLimit</a></div>
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
			<td id="prometheus--podMonitor--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L514">prometheus.podMonitor.enabled</a></div>
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
			<td id="prometheus--podMonitor--namespace">
              <div style="max-width: 250px;"><a href="./values.yaml#L516">prometheus.podMonitor.namespace</a></div>
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
			<td id="prometheus--podMonitor--additionalLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L518">prometheus.podMonitor.additionalLabels</a></div>
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
			<td id="prometheus--podMonitor--podTargetLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L521">prometheus.podMonitor.podTargetLabels</a></div>
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
			<td id="prometheus--podMonitor--apiVersion">
              <div style="max-width: 250px;"><a href="./values.yaml#L523">prometheus.podMonitor.apiVersion</a></div>
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
			<td id="prometheus--podMonitor--selectorOverride">
              <div style="max-width: 250px;"><a href="./values.yaml#L525">prometheus.podMonitor.selectorOverride</a></div>
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
			<td id="prometheus--podMonitor--attachMetadata">
              <div style="max-width: 250px;"><a href="./values.yaml#L527">prometheus.podMonitor.attachMetadata</a></div>
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
			<td id="prometheus--podMonitor--jobLabel">
              <div style="max-width: 250px;"><a href="./values.yaml#L530">prometheus.podMonitor.jobLabel</a></div>
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
			<td id="prometheus--podMonitor--scheme">
              <div style="max-width: 250px;"><a href="./values.yaml#L533">prometheus.podMonitor.scheme</a></div>
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
			<td id="prometheus--podMonitor--path">
              <div style="max-width: 250px;"><a href="./values.yaml#L535">prometheus.podMonitor.path</a></div>
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
			<td id="prometheus--podMonitor--basicAuth">
              <div style="max-width: 250px;"><a href="./values.yaml#L539">prometheus.podMonitor.basicAuth</a></div>
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
			<td id="prometheus--podMonitor--tlsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L542">prometheus.podMonitor.tlsConfig</a></div>
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
			<td id="prometheus--podMonitor--authorization">
              <div style="max-width: 250px;"><a href="./values.yaml#L545">prometheus.podMonitor.authorization</a></div>
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
			<td id="prometheus--podMonitor--oauth2">
              <div style="max-width: 250px;"><a href="./values.yaml#L548">prometheus.podMonitor.oauth2</a></div>
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
			<td id="prometheus--podMonitor--proxyUrl">
              <div style="max-width: 250px;"><a href="./values.yaml#L551">prometheus.podMonitor.proxyUrl</a></div>
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
			<td id="prometheus--podMonitor--interval">
              <div style="max-width: 250px;"><a href="./values.yaml#L553">prometheus.podMonitor.interval</a></div>
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
			<td id="prometheus--podMonitor--scrapeTimeout">
              <div style="max-width: 250px;"><a href="./values.yaml#L555">prometheus.podMonitor.scrapeTimeout</a></div>
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
			<td id="prometheus--podMonitor--honorTimestamps">
              <div style="max-width: 250px;"><a href="./values.yaml#L557">prometheus.podMonitor.honorTimestamps</a></div>
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
			<td id="prometheus--podMonitor--honorLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L559">prometheus.podMonitor.honorLabels</a></div>
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
			<td id="prometheus--podMonitor--enableHttp2">
              <div style="max-width: 250px;"><a href="./values.yaml#L561">prometheus.podMonitor.enableHttp2</a></div>
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
			<td id="prometheus--podMonitor--filterRunning">
              <div style="max-width: 250px;"><a href="./values.yaml#L564">prometheus.podMonitor.filterRunning</a></div>
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
			<td id="prometheus--podMonitor--followRedirects">
              <div style="max-width: 250px;"><a href="./values.yaml#L566">prometheus.podMonitor.followRedirects</a></div>
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
			<td id="prometheus--podMonitor--params">
              <div style="max-width: 250px;"><a href="./values.yaml#L568">prometheus.podMonitor.params</a></div>
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
			<td id="prometheus--podMonitor--relabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L574">prometheus.podMonitor.relabelings</a></div>
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
			<td id="prometheus--podMonitor--metricRelabelings">
              <div style="max-width: 250px;"><a href="./values.yaml#L576">prometheus.podMonitor.metricRelabelings</a></div>
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
			<td id="prometheus--podMonitor--sampleLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L579">prometheus.podMonitor.sampleLimit</a></div>
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
			<td id="prometheus--podMonitor--targetLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L581">prometheus.podMonitor.targetLimit</a></div>
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
			<td id="prometheus--podMonitor--labelLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L584">prometheus.podMonitor.labelLimit</a></div>
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
			<td id="prometheus--podMonitor--labelNameLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L587">prometheus.podMonitor.labelNameLengthLimit</a></div>
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
			<td id="prometheus--podMonitor--labelValueLengthLimit">
              <div style="max-width: 250px;"><a href="./values.yaml#L590">prometheus.podMonitor.labelValueLengthLimit</a></div>
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
			<td id="updateStrategy">
              <div style="max-width: 250px;"><a href="./values.yaml#L593">updateStrategy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L601">resources</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L614">restartPolicy</a></div>
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
			<td id="serviceAccount--create">
              <div style="max-width: 250px;"><a href="./values.yaml#L618">serviceAccount.create</a></div>
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
			<td id="serviceAccount--name">
              <div style="max-width: 250px;"><a href="./values.yaml#L621">serviceAccount.name</a></div>
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
			<td id="serviceAccount--annotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L622">serviceAccount.annotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L623">serviceAccount.imagePullSecrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L625">serviceAccount.automountServiceAccountToken</a></div>
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
			<td id="securityContext">
              <div style="max-width: 250px;"><a href="./values.yaml#L630">securityContext</a></div>
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
			<td id="containerSecurityContext--privileged">
              <div style="max-width: 250px;"><a href="./values.yaml#L639">containerSecurityContext.privileged</a></div>
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
			<td id="containerSecurityContext--readOnlyRootFilesystem">
              <div style="max-width: 250px;"><a href="./values.yaml#L641">containerSecurityContext.readOnlyRootFilesystem</a></div>
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
			<td id="hostNetwork">
              <div style="max-width: 250px;"><a href="./values.yaml#L647">hostNetwork</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L650">hostPID</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L653">hostIPC</a></div>
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
			<td id="hostRootFsMount">
              <div style="max-width: 250px;"><a href="./values.yaml#L656">hostRootFsMount</a></div>
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
			<td id="hostRootFsMount--mountPropagation">
              <div style="max-width: 250px;"><a href="./values.yaml#L663">hostRootFsMount.mountPropagation</a></div>
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
			<td id="hostProcFsMount--mountPropagation">
              <div style="max-width: 250px;"><a href="./values.yaml#L668">hostProcFsMount.mountPropagation</a></div>
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
			<td id="hostSysFsMount--mountPropagation">
              <div style="max-width: 250px;"><a href="./values.yaml#L673">hostSysFsMount.mountPropagation</a></div>
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
			<td id="affinity">
              <div style="max-width: 250px;"><a href="./values.yaml#L678">affinity</a></div>
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
			<td id="podAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L688">podAnnotations</a></div>
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
			<td id="podLabels">
              <div style="max-width: 250px;"><a href="./values.yaml#L691">podLabels</a></div>
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
			<td id="daemonsetAnnotations">
              <div style="max-width: 250px;"><a href="./values.yaml#L694">daemonsetAnnotations</a></div>
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
			<td id="dnsConfig">
              <div style="max-width: 250px;"><a href="./values.yaml#L697">dnsConfig</a></div>
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
			<td id="nodeSelector">
              <div style="max-width: 250px;"><a href="./values.yaml#L710">nodeSelector</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L715">terminationGracePeriodSeconds</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L718">tolerations[0].effect</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L719">tolerations[0].operator</a></div>
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
			<td id="terminationMessageParams--enabled">
              <div style="max-width: 250px;"><a href="./values.yaml#L724">terminationMessageParams.enabled</a></div>
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
			<td id="terminationMessageParams--terminationMessagePath">
              <div style="max-width: 250px;"><a href="./values.yaml#L726">terminationMessageParams.terminationMessagePath</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L728">terminationMessageParams.terminationMessagePolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L731">priorityClassName</a></div>
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
			<td id="extraHostVolumeMounts">
              <div style="max-width: 250px;"><a href="./values.yaml#L735">extraHostVolumeMounts</a></div>
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
			<td id="configmaps">
              <div style="max-width: 250px;"><a href="./values.yaml#L746">configmaps</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L752">secrets</a></div>
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
			<td id="extraManifests">
              <div style="max-width: 250px;"><a href="./values.yaml#L757">extraManifests</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L767">extraVolumes</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L775">extraVolumeMounts</a></div>
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
			<td id="extraInitContainers">
              <div style="max-width: 250px;"><a href="./values.yaml#L782">extraInitContainers</a></div>
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
			<td id="livenessProbe">
              <div style="max-width: 250px;"><a href="./values.yaml#L786">livenessProbe</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L795">readinessProbe</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L803">version</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L807">redfishProxy.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L809">redfishProxy.imagePullSecrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L814">redfishProxy.revisionHistoryLimit</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L819">redfishProxy.rbac.create</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L821">redfishProxy.rbac.extraClusterRoleRules</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L828">redfishProxy.insecureSkipVerify</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L843">redfishProxy.additionalArgs</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L851">redfishProxy.kubeRBACProxy.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L853">redfishProxy.kubeRBACProxy.env</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L857">redfishProxy.kubeRBACProxy.image.registry</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L858">redfishProxy.kubeRBACProxy.image.repository</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L859">redfishProxy.kubeRBACProxy.image.tag</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L860">redfishProxy.kubeRBACProxy.image.sha</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L861">redfishProxy.kubeRBACProxy.image.pullPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L878">redfishProxy.kubeRBACProxy.additionalArgs</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L883">redfishProxy.kubeRBACProxy.containerSecurityContext</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L888">redfishProxy.kubeRBACProxy.port</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L890">redfishProxy.kubeRBACProxy.portName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L892">redfishProxy.kubeRBACProxy.enableHostPort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L896">redfishProxy.kubeRBACProxy.proxyEndpointsPort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L898">redfishProxy.kubeRBACProxy.enableProxyEndpointsHostPort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L903">redfishProxy.kubeRBACProxy.resources</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L914">redfishProxy.kubeRBACProxy.extraVolumeMounts</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L922">redfishProxy.kubeRBACProxy.tls</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L931">redfishProxy.tlsSecret.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L933">redfishProxy.tlsSecret.caItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L935">redfishProxy.tlsSecret.certItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L937">redfishProxy.tlsSecret.keyItem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L939">redfishProxy.tlsSecret.secretName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L941">redfishProxy.tlsSecret.volumeName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L946">redfishProxy.service.enabled</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L949">redfishProxy.service.type</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L951">redfishProxy.service.clusterIP</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L954">redfishProxy.service.port</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L957">redfishProxy.service.servicePort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L959">redfishProxy.service.targetPort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L961">redfishProxy.service.portName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L963">redfishProxy.service.nodePort</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L966">redfishProxy.service.listenOnAllInterfaces</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L969">redfishProxy.service.annotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L970">redfishProxy.service.labels</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L974">redfishProxy.service.ipDualStack</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L981">redfishProxy.service.externalTrafficPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L984">redfishProxy.service.internalTrafficPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L988">redfishProxy.networkPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L998">redfishProxy.env</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1003">redfishProxy.updateStrategy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1011">redfishProxy.resources</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1023">redfishProxy.restartPolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1027">redfishProxy.serviceAccount.create</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1030">redfishProxy.serviceAccount.name</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1031">redfishProxy.serviceAccount.annotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1032">redfishProxy.serviceAccount.imagePullSecrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1033">redfishProxy.serviceAccount.automountServiceAccountToken</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1036">redfishProxy.securityContext.runAsGroup</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1037">redfishProxy.securityContext.runAsNonRoot</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1038">redfishProxy.securityContext.runAsUser</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1041">redfishProxy.containerSecurityContext.privileged</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1042">redfishProxy.containerSecurityContext.readOnlyRootFilesystem</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1043">redfishProxy.containerSecurityContext.allowPrivilegeEscalation</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1049">redfishProxy.hostNetwork</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1052">redfishProxy.hostPID</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1055">redfishProxy.hostIPC</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1059">redfishProxy.affinity</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1070">redfishProxy.podAnnotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1073">redfishProxy.podLabels</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1076">redfishProxy.deployAnnotations</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1079">redfishProxy.dnsConfig</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1091">redfishProxy.nodeSelector</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1096">redfishProxy.terminationGracePeriodSeconds</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1099">redfishProxy.tolerations[0].effect</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1100">redfishProxy.tolerations[0].operator</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1104">redfishProxy.terminationMessageParams</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1107">redfishProxy.terminationMessageParams.terminationMessagePath</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1109">redfishProxy.terminationMessageParams.terminationMessagePolicy</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1112">redfishProxy.priorityClassName</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1115">redfishProxy.extraHostVolumeMounts</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1125">redfishProxy.configmaps</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1130">redfishProxy.secrets</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1135">redfishProxy.extraInitContainers</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1138">redfishProxy.extraManifests</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1148">redfishProxy.extraVolumes</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1156">redfishProxy.extraVolumeMounts</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1162">redfishProxy.livenessProbe</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1170">redfishProxy.readinessProbe</a></div>
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
              <div style="max-width: 250px;"><a href="./values.yaml#L1178">redfishProxy.version</a></div>
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

# CEEMS Kubernetes Helm Charts

This functionality is in beta and is subject to change. The code is provided as-is with no
warranties. Beta features are not subject to the support SLA of official GA features.

## Usage

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [documentation](https://helm.sh/docs/) to get started.

Once Helm is set up properly, add the repository as follows:

```console
helm repo add ceems-dev https://ceems-dev.github.io/helm-charts
```

You can then run `helm search repo ceems-dev` to see the charts.

OCI artifacts of all Prometheus Helm charts are available in
[ghcr.io](https://github.com/orgs/ceems-dev/packages?repo_name=helm-charts).

## Contributing

The source code of all [CEEMS](https://ceems-dev.github.io/ceems/docs/) community
[Helm](https://helm.sh) charts can be found on GitHub: <https://github.com/ceems-dev/helm-charts/>

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
We'd love to have you contribute! Please refer to our
[contribution guidelines](https://github.com/ceems-dev/helm-charts/blob/main/CONTRIBUTING.md) for details.

## License

<!-- Keep full URL links to repo files because this README syncs from main to gh-pages.  -->
[Apache 2.0 License](https://github.com/ceems-dev/helm-charts/blob/main/LICENSE).

## Helm charts build status

![Release Charts](https://github.com/ceems-dev/helm-charts/actions/workflows/release.yaml/badge.svg?branch=main)

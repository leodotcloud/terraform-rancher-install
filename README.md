# Terraform | Rancher Install

Terraform module to install Rancher using helm to complete an HA installation.

### Usage

```hcl
module "rancher_install" {
  source = "github.com/terraform-rancher-modules/terraform-rancher-install"

  rancher_hostname = "rancher.example.com"
}
```

## Examples

#### Custom kubeconfig location

```hcl
module "rancher_install" {
  source = "github.com/terraform-rancher-modules/terraform-rancher-install"

  rancher_hostname = "rancher.example.com"
	kubeconfig_file  = "/path/to/kubeconfig"
}
```

#### Single replica for Rancher, and pin the version

```hcl
module "rancher_install" {
  source = "github.com/terraform-rancher-modules/terraform-rancher-install"

  rancher_hostname = "rancher.example.com"
	rancher_replicas  = 1
	rancher_version   = "2.6.2"
}
```

#### Additional values for the Rancher chart

```hcl
module "rancher_install" {
  source = "github.com/terraform-rancher-modules/terraform-rancher-install"

  rancher_hostname = "rancher.example.com"
  rancher_additional_helm_values = [
    "bootstrapPassword: secret-string",
    "auditLog.level: 1"
  ]
}
```

## Providers

| Name | Version |
|------|---------|
| helm | >= 2.4.1 |
| kubernetes | >= 2.6.1 |

## Inputs

| Name | Default | Required / Optional | Description |
| ---|---|---|---|
| kubeconfig_file | ~/.kube/config | Optional | The kubeconfig to use to interact with the cluster |
| cert_manager_namespace | cert-manager | Optional | cert-manager namespace |
| cert_manager_version | v1.5.1 | Optional | cert-manager version to install |
| rancher_additional_helm_values | null | Optional | (list) Helm options to provide to the Rancher helm chart |
| rancher_antiaffinity | required | Optional | Value for antiAffinity when installing the Rancher helm chart |
| rancher_bootstrap_password | admin | Optional | Rancher bootstrap password to use initially |
| rancher_hostname | null | Required | Value for the Rancher hostname when installing the Rancher helm chart |
| rancher_replicas | 3 | Optional | Value for the Rancher replicas when installing the Rancher helm chart |
| rancher_version | null (stable version) | Optional | Rancher version to install |
| cacerts_path | null | Optional | Private CA certificate to use for UI/API connectivity |
| tls_crt_path | null | Optional | TLS certificate to use for UI/API connectivity |
| tls_key_path | null | Optional | TLS key to use for UI/API connectivity |
| tls_source | rancher | Optional | Value for the Rancher `ingress.tls.source` when installing the Rancher helm chart |

## Outputs

| Output | Description |
| ---------|-------------|
| rancher_hostname | The value of `var.rancher_hostname`, used for chaining further modules |
| rancher_bootstrap_password | (sensitive) The value of `var.rancher_bootstrap_password`, used for bootstraping Rancher |
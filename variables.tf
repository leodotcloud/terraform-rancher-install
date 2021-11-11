variable "kubeconfig_file" {
  default = "~/.kube/config"
}

variable "cert_manager_namespace" {
  default = "cert-manager"
}

variable "cert_manager_version" {
  default = "v1.5.1"
}

variable "rancher_additional_helm_values" {
  default = []
  type    = list(string)
}

variable "rancher_antiaffinity" {
  default = "required"
}

variable "rancher_bootstrap_password" {
  default = "admin"
}

variable "rancher_hostname" {
}

variable "rancher_replicas" {
  default = 3
}

variable "rancher_version" {
  default = null
}

variable "cacerts_path" {
  default = null
}

variable "tls_crt_path" {
  default = null
}

variable "tls_key_path" {
  default = null
}

variable "tls_source" {
  default = "rancher"
}
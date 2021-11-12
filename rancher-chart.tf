resource "helm_release" "rancher_server" {
  depends_on = [
    kubernetes_secret.tls-rancher-ingress,
    kubernetes_secret.tls-ca,
    kubernetes_secret.helm_image_pull_secret,
    helm_release.cert_manager,
  ]

  repository       = var.rancher_helm_repository
  name             = "rancher"
  chart            = "rancher"
  version          = var.rancher_version
  namespace        = "cattle-system"
  create_namespace = true
  wait             = true

  set {
    name  = "hostname"
    value = var.rancher_server_dns
  }

  set {
    name = "replicas"
    value = var.rancher_replicas
  }

  set {
    name = "bootstrapPassword"
    value = var.rancher_bootstrap_password
  }

  dynamic "set" {
    for_each = var.ingress_tls_source != "secret" ? [1] : []
    content {
      name  = "certmanager.version"
      value = var.cert_manager_version
    }
  }

  dynamic "set" {
    for_each = var.ingress_tls_source != "rancher" ? [1] : []
    content {
      name = "ingress.tls.source"
      value = var.ingress_tls_source
    }
  }

  dynamic "set" {
    for_each = var.system_default_registry != null ? [1] : []
    content {
      name = "systemDefaultRegistry"
      value = var.system_default_registry
    }
  }

  dynamic "set" {
    for_each = var.rancher_image_registry != null ? [1] : []
    content {
      name = "rancherImage"
      value = "${var.rancher_image_registry}/rancher/rancher"
    }
  }

  dynamic "set" {
    for_each = var.use_private_ca ? [1]: []
    content {
      name = "privateCA"
      value = var.use_private_ca
    }
  }

  dynamic "set" {
    for_each = var.rancher_image_registry_username != null ? [1] : []
    content {
      name = "imagePullSecrets[0].name"
      value = local.rancher_image_registry_secret_name
    }
  }

}
output "rancher_hostname" {
  value = var.rancher_hostname
}

output "rancher_bootstrap_password" {
  value     = var.rancher_bootstrap_password
  sensitive = true
}
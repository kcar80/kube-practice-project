output "namespace_name" {
  value = kubernetes_manifest.namespace.manifest.metadata.name
}

output "service_name" {
  value = kubernetes_manifest.service.manifest.metadata.name
}

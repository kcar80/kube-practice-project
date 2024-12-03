resource "kubernetes_manifest" "namespace" {
  manifest = {
    apiVersion = "v1"
    kind       = "Namespace"
    metadata = {
      name = var.namespace
    }
  }
}

resource "kubernetes_manifest" "deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata = {
      name      = var.app_name
      namespace = var.namespace
    }
    spec = {
      replicas = var.replicas
      selector = {
        matchLabels = {
          app = var.app_name
        }
      }
      template = {
        metadata = {
          labels = {
            app = var.app_name
          }
        }
        spec = {
          containers = [
            {
              name  = var.app_name
              image = var.image
              ports = [
                {
                  containerPort = var.container_port
                }
              ]
            }
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata = {
      name      = "${var.app_name}-service"
      namespace = var.namespace
    }
    spec = {
      selector = {
        app = var.app_name
      }
      ports = [
        {
          port       = var.service_port
          targetPort = var.container_port
        }
      ]
      type = var.service_type
    }
  }
}

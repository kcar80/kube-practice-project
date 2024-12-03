terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.13"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "null" {}

resource "null_resource" "install_minikube" {
  provisioner "local-exec" {
    command = "minikube start --driver=docker"
  }

  triggers = {
    cluster_version = "1.25.0"
  }
}

output "minikube_installed" {
  value = "Minikube is installed and running!"
}

module "kubernetes" {
  source          = "./modules/kubernetes"
  namespace       = "kube-practice"
  app_name        = "practice-app"
  image           = "nginx:stable"
  replicas        = 2
  container_port  = 80
  service_port    = 80
  service_type    = "NodePort"
}

output "namespace" {
  value = module.kubernetes.namespace_name
}

output "service" {
  value = module.kubernetes.service_name
}

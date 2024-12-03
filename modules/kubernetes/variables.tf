variable "namespace" {
  type        = string
  description = "The namespace to create"
}

variable "app_name" {
  type        = string
  description = "Name of the application"
}

variable "image" {
  type        = string
  description = "Container image for the application"
}

variable "replicas" {
  type        = number
  description = "Number of replicas for the deployment"
  default     = 2
}

variable "container_port" {
  type        = number
  description = "Port exposed by the container"
  default     = 80
}

variable "service_port" {
  type        = number
  description = "Port exposed by the service"
  default     = 80
}

variable "service_type" {
  type        = string
  description = "Type of Kubernetes service"
  default     = "NodePort"
}

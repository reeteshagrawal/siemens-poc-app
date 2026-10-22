variable "region" {
  description = "AWS region to deploy into."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name prefix used for all resources."
  type        = string
  default     = "siemens-poc-app"
}

variable "environment" {
  description = "Environment name (dev, test, prod...)."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public (ALB) subnets, one per AZ."
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private (task) subnets, one per AZ."
  type        = list(string)
  default     = ["10.0.128.0/20", "10.0.144.0/20"]
}

variable "image_tag" {
  description = "Tag of the container image in ECR to deploy."
  type        = string
  default     = "latest"
}

variable "container_port" {
  description = "Port the Spring Boot application listens on inside the container."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP path the ALB uses for target health checks."
  type        = string
  default     = "/hello"
}

variable "task_cpu" {
  description = "Fargate task CPU units (1024 = 1 vCPU)."
  type        = number
  default     = 512
}

variable "task_memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Number of ECS tasks to run."
  type        = number
  default     = 1
}

variable "log_retention_days" {
  description = "CloudWatch Logs retention in days."
  type        = number
  default     = 30
}

variable "allowed_ingress_cidrs" {
  description = "CIDR blocks allowed to reach the ALB on port 80."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

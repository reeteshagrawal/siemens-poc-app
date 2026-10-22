output "application_url" {
  description = "Public URL of the application endpoint."
  value       = "http://${aws_lb.main.dns_name}${var.health_check_path}"
}

output "alb_dns_name" {
  description = "DNS name of the application load balancer."
  value       = aws_lb.main.dns_name
}

output "ecr_repository_url" {
  description = "ECR repository to push the container image to."
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  value       = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  description = "Name of the ECS service."
  value       = aws_ecs_service.app.name
}

output "cloudwatch_log_group" {
  description = "CloudWatch Logs group receiving container output."
  value       = aws_cloudwatch_log_group.app.name
}

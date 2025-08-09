output "ecr_repo_url"  { value = aws_ecr_repository.repo.repository_url }
output "cluster_name"  { value = aws_ecs_cluster.this.name }
output "service_name"  { value = aws_ecs_service.svc.name }
output "how_to_find_task_public_ip" {
  value = "aws ecs list-tasks --cluster ${aws_ecs_cluster.this.name} --service-name ${aws_ecs_service.svc.name} | jq -r '.taskArns[0]' → then describe-tasks → get ENI → describe-network-interfaces"
}

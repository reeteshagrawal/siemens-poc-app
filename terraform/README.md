# ECS Fargate deployment (OpenTofu)

Deploys the Spring Boot app (Java 21) as an ECS Fargate service behind a public
Application Load Balancer.

## Resources created

- VPC with 2 public and 2 private subnets, internet gateway, single NAT gateway
- Security groups: ALB open on port 80, tasks reachable only from the ALB
- ECR repository (scan on push, keeps the last 10 images)
- ECS cluster, Fargate task definition and service in the private subnets
- ALB, HTTP listener and IP target group health-checked on `/hello`
- CloudWatch log group `/ecs/<project>-<env>` and task/execution IAM roles

## Usage

1. Build the jar and container image, then push it to ECR.

   ```sh
   cd ../app && ./mvnw clean package && cd ..

   cd terraform
   cp terraform.tfvars.example terraform.tfvars   # edit as needed
   tofu init
   tofu apply -target=aws_ecr_repository.app      # create the registry first

   REPO=$(tofu output -raw ecr_repository_url)
   aws ecr get-login-password --region us-east-1 \
     | docker login --username AWS --password-stdin "${REPO%%/*}"
   docker build -f ../build/Dockerfile -t "$REPO:latest" ..
   docker push "$REPO:latest"
   ```

2. Deploy everything.

   ```sh
   tofu apply
   tofu output application_url
   ```

3. Tear down.

   ```sh
   tofu destroy
   ```

## Notes

- State is local. For shared use, add an S3 + DynamoDB `backend "s3"` block to
  `versions.tf`.
- The listener is HTTP only. For TLS, add an ACM certificate and an HTTPS
  listener, then redirect port 80 to 443.
- `image_tag` defaults to `latest`; pin it to an immutable tag (e.g. the git
  SHA) so `tofu apply` triggers a real deployment on each release.
- One NAT gateway is used to limit POC cost; use one per AZ for production HA.

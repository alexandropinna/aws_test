# --- IAM Role for ECS (Elastic Container Service) Execution ---

# Create an IAM role for ECS execution
resource "aws_iam_role" "ecs_execution_role" {
  # Role name
  name = "ecs_execution_role"

  # Policy to assume the role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Associate a predefined AWS policy to the ECS role
resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# --- Resources for ECS (Elastic Container Service) ---

# Create an ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

# Define the ECS task
resource "aws_ecs_task_definition" "ecs_tec" {
  family                   = var.task_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  # Container definitions
  container_definitions = jsonencode([{
    name  = "aws_image"
    image = "alex919090/aws_image"
    portMappings = [
      {
        containerPort = 80
        hostPort      = 80
      },
      {
        containerPort = 81
        hostPort      = 81
      },
      {
        containerPort = 82
        hostPort      = 82
      },
      {
        containerPort = 83
        hostPort      = 83
      }
    ]

    # Environment variables for the container
    environment = [
      {
        name  = "DB_HOST",
        value = var.db_host
      },
      {
        name  = "DB_PORT",
        value = var.db_port
      },
      {
        name  = "DB_USER",
        value = var.db_username
      },
      {
        name  = "DB_PASS",
        value = var.db_password
      }
    ]
  }])
}

# Create the ECS service
resource "aws_ecs_service" "nginx_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_tec.arn
  launch_type     = "FARGATE"

  # Network configuration for the ECS service
  network_configuration {
    subnets          = [var.public_subnet_id]
    security_groups  = [var.sg_public_instance_id]
    assign_public_ip = true
  }

  # Desired number of task instances
  desired_count = 1
}

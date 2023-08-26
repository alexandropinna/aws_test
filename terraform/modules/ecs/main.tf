##### IAM ROLE FOR ECS EXECUTION
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

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

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
##### IAM ROLE FOR ECS EXECUTION

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "arroyo-prueba_tec" {
  family                   = var.task_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name  = "arroyo-prueba-tec"
    image = "alex919090/arroyo-prueba-tec:latest"
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

resource "aws_ecs_service" "nginx_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.arroyo-prueba_tec.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [var.public_subnet_id]
    security_groups = [var.sg_public_instance_id]

    assign_public_ip = true
  }
  desired_count = 1
}


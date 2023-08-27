# --- IAM Role para la ejecución de ECS (Elastic Container Service) ---

# Crear un rol IAM para la ejecución de ECS
resource "aws_iam_role" "ecs_execution_role" {
  # Nombre del rol
  name = "ecs_execution_role"

  # Política para asumir el rol
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

# Asociar una política predefinida de AWS al rol de ECS
resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# --- Recursos para ECS (Elastic Container Service) ---

# Crear un cluster ECS
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.cluster_name
}

# Definir la tarea ECS
resource "aws_ecs_task_definition" "arroyo-prueba_tec" {
  family                   = var.task_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  # Definiciones del contenedor
  container_definitions = jsonencode([{
    name  = "arroyo-consulting-prueba"
    image = "alex919090/arroyo-consulting-prueba"
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]

    # Variables de entorno para el contenedor
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

# Crear el servicio ECS
resource "aws_ecs_service" "nginx_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.arroyo-prueba_tec.arn
  launch_type     = "FARGATE"

  # Configuración de red para el servicio ECS
  network_configuration {
    subnets          = [var.public_subnet_id]
    security_groups  = [var.sg_public_instance_id]
    assign_public_ip = true
  }

  # Número deseado de instancias de la tarea
  desired_count = 1
}

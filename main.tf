terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # substitua pela sua região desejada
}

resource "aws_db_instance" "meu_banco_de_dados" {
  # Configurações do seu banco de dados
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.6"
  instance_class       = "db.t2.micro"
  db_name              = "example-db"
  username             = "admin"
  password             = "suaSenhaSegura123"  # Substitua pela sua senha
  parameter_group_name = "default.postgres12"
  publicly_accessible  = false
}

resource "aws_iam_role" "meu_role" {
  name = "meu-role-rds"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "minha_politica" {
  name        = "minha-politica-rds"
  description = "Permite acesso ao banco de dados RDS"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "rds-db:connect"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "minha_politica_attachment" {
  role       = aws_iam_role.meu_role.name
  policy_arn = aws_iam_policy.minha_politica.arn
}



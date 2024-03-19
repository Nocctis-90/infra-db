terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "example" {
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

  tags = {
    Name = "ExampleDB"
  }
} 


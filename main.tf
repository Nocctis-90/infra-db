provider "aws" {
  region = "us-east-1"  # substitua pela sua região desejada
}

resource "aws_db_instance" "meu_banco_de_dados" {
  # Configurações do seu banco de dados
  instance_class = "db.t2.micro"
  engine         = "mysql"
  username       = "usuario"
  password       = "senha"
  allocated_storage = 20
  identifier     = "meu-banco-de-dados"
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





resource "aws_db_instance" "default" {
  allocated_storage    = 20
  db_name              = "fasfoodproducaodb"
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = "db.t3.micro"
  username             = teste
  password             = teste124
}
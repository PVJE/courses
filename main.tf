
resource "aws_db_instance" "db" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.db_instance_class
  name                   = var.db_name
  username               = var.username
  password               = var.password
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  skip_final_snapshot    = true
}

resource "aws_key_pair" "ec2-key" {
  key_name   = "deployer-key"
  public_key = var.public_key
}
resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  key_name               = aws_key_pair.ec2-key.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.name
}
 
resource "aws_s3_bucket" "my_bucket" {
    bucket        = var.s3_bucket_name
    acl           = "private"
}

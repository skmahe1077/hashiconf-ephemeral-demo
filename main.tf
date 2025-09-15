# Ephemeral resource generates a password at runtime (never stored in state or plan)
ephemeral "random_password" "hashiconf_db_password" {
  length           = 16
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Secrets Manager stores the password via write-only (value not persisted in state/plan)
resource "aws_secretsmanager_secret" "hashiconf_db_password" {
  name = "hashiconf-ephemeral-db-password"
  tags = {
    Name        = "hashiconf-ephemeral-secret"
    Project     = "HashiConf Demo"
  }
}

# Write-only secret version with version counter for rotation
resource "aws_secretsmanager_secret_version" "hashiconf_db_password" {
  secret_id                = aws_secretsmanager_secret.hashiconf_db_password.id
  secret_string_wo         = ephemeral.random_password.hashiconf_db_password.result
  secret_string_wo_version = var.secret_version
}

# Ephemeral readback of the stored secret (still never stored in state/plan)
ephemeral "aws_secretsmanager_secret_version" "hashiconf_db_password" {
  secret_id = aws_secretsmanager_secret.hashiconf_db_password.id
}

# RDS instance consumes the password securely using write-only + version tracking
resource "aws_db_instance" "hashiconf_rds" {
  identifier          = "hashiconf-ephemeral-rds"
  engine              = "postgres"
  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  username            = "dbadmin"
  skip_final_snapshot = true
  password_wo         = ephemeral.aws_secretsmanager_secret_version.hashiconf_db_password.secret_string
  password_wo_version = aws_secretsmanager_secret_version.hashiconf_db_password.secret_string_wo_version
  tags = {
    Name        = "hashiconf-ephemeral-rds"
    Project     = "HashiConf Demo"
  }
}


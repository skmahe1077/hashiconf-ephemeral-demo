variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS region for the demo"
}

# Increment this value to rotate the RDS password without ever exposing it
variable "secret_version" {
  type        = number
  default     = 1
  description = "Version counter for write-only secret rotation"
}

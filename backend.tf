terraform {
  backend "s3" {
    bucket = "hashiconf-tfstate-25-09-2025"          
    key    = "hashiconf-ephemeral.tfstate" 
    region = "eu-west-1"                         
    encrypt = true     
  }
}

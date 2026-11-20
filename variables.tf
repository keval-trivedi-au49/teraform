variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "ami_id" {
  description = "Ubuntu AMI (ap-south-1)"
  type        = string
  default     = "ami-083cf4acad89c8905"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type    = string
  default = "subnet-0b62b0c78afb807ae"
}

variable "key_name" {
  type    = string
  default = "for_tf"
}

variable "ssh_cidr" {
  type        = string
  default     = "0.0.0.0/0"
}

variable "repo_url" {
  type        = string
}

variable "repo_branch_backend" {
  type    = string
  default = "seperate_backend"
}

variable "mongo_uri" {
  type        = string
  sensitive   = true
}

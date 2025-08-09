variable "region"         { type = string  default = "us-east-1" }
variable "project_name"   { type = string  default = "flask-secure-app" }
variable "container_port" { type = number  default = 5000 }
variable "cpu"            { type = number  default = 256 }
variable "memory"         { type = number  default = 512 }


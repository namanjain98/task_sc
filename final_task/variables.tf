variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type    = string
  default = "ami-0c4f7023847b90238"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "vpc_id" {
  type    = string
  default = "vpc-bb78e8c6"
}

variable "sg_instance" {
  type    = string
  default = "task-sg"
}

variable "sg_alb" {
  type    = string
  default = "task-alb"
}

variable "subnets" {
  type    = list(any)
  default = ["subnet-ef2a6ab0", "subnet-ca3374ac", "subnet-07c78526"]
}

variable "cross_zone_load_balancing" {
  type    = bool
  default = true
}

variable "connection_draining" {
  type    = bool
  default = true
}

variable "elb_name" {
  default = "task-elb"
}
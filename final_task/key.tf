resource "tls_private_key" "task" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "task" {
  key_name   = "task-key"
  public_key = tls_private_key.task.public_key_openssh
}

resource "local_file" "local_ssh_private_key" {
  content         = tls_private_key.task.private_key_pem
  filename        = "task"
  file_permission = "644"
}

resource "local_file" "local_ssh_public_key" {
  content         = tls_private_key.task.public_key_openssh
  filename        = "task.pub"
  file_permission = "600"
} 
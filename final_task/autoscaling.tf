resource "aws_launch_configuration" "task-launchconfig" {
  name_prefix     = "task-launchconfig"
  image_id        = var.AMIS
  instance_type   = var.instance_type
  key_name        = aws_key_pair.task.key_name
  security_groups = [aws_security_group.myinstance.id]
  user_data       = file("install-httpd.sh")
  #iam_instance_profile=aws_iam_instance_profile.test_profile.name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "task-autoscaling" {
  name                      = "task-autoscaling"
  vpc_zone_identifier       = var.subnets
  launch_configuration      = aws_launch_configuration.task-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  target_group_arns         = [aws_lb_target_group.lb_target.arn]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}


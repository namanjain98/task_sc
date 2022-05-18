resource "aws_lb" "lb" {
  name               = "task-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb-securitygroup.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "lb_target" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 2
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  name        = "task-alb-tg"
  port        = 8000
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}



resource "aws_lb_listener" "listener_two" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 8000
  protocol          = "HTTP"
  default_action {
    order =1
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn

  }
}



resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.listener_two.arn
  priority     = 1

  action {
    order            = 1
    type             = "redirect"
    target_group_arn = aws_lb_target_group.lb_target.arn
     redirect {
            host        = "#{host}"
            path        = "/"
            port        = "8000"
            protocol    = "#{protocol}"
            status_code = "HTTP_302"
        }
  }

  condition {

        path_pattern {
            values = [
                "/ec2",
            ]
        }
    }
}


output "lb_url"{
   value=aws_lb.lb
}

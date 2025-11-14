resource "aws_autoscaling_group" "app_asg" {
  vpc_zone_identifier       = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "auto-scaling-instance"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "demo_launch_cfg" {
  name_prefix = "demo_launch_config"
  image_id = var.AMIS[var.aws_region]
  instance_type = var.demo_instance_type
  key_name = aws_key_pair.demokeypair.key_name
  security_groups = [aws_security_group.demoSg.id]
  user_data = <<-EOF
        #! /bin/bash
        sudo yum install httpd
        systemctl start httpd
        systemctl enable httpd
        demoIP=`ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`
        echo 'This is My demoserver: '$demoIP >> /var/www/html/index.html
        EOF
}
resource "aws_autoscaling_group" "demo_ASG" {
  name = "demo_ASG"
  vpc_zone_identifier = [aws_subnet.demo-main-public-1.id, aws_subnet.demo-main-public-2.id]
  launch_configuration = aws_launch_configuration.demo_launch_cfg.name
  min_size = 2
  max_size = 3
  health_check_grace_period = 300
  health_check_type = "ELB"
  load_balancers = [aws_elb.demoELB.name]
  force_delete = true
  tag {
      key = "Name"
      value = "ec2-instance"
      propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "demo_CPU_Usage" {
  name = "demo_Autoscaling_Policy"
  autoscaling_group_name = aws_autoscaling_group.demo_ASG.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}
resource "aws_cloudwatch_metric_alarm" "demo_CPU_Alarm" {
  alarm_name = "demo_CPU_Alarm"
  alarm_description = "demo_CPU_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"
  dimensions = {
      "AutoScalingGroupName" = aws_autoscaling_group.demo_ASG.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.demo_CPU_Usage.arn]
}

##scale down alarm

resource "aws_autoscaling_policy" "demo_CPU_Policy_scaledown" {
  name = "demo_CPU_Policy_scaledown"
  autoscaling_group_name = aws_autoscaling_group.demo_ASG.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"

}
resource "aws_cloudwatch_metric_alarm" "demo_CPU_Alarm_scaledown" {
  alarm_name = "demo_CPU_Alarm_scaledown"
  alarm_description = "demo_CPU_Alarm_scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "5"
  dimensions = {
      "AutoScalingGroupName" = aws_autoscaling_group.demo_ASG.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.demo_CPU_Policy_scaledown.arn] 
}

resource "aws_elb" "demoELB" {
    name = "demoELB"
    subnets = [aws_subnet.demo-main-public-1.id, aws_subnet.demo-main-public-2.id]
    security_groups = [aws_security_group.demo_ELB_SG.id]
    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }
  health_check {
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 3
      target = "HTTP:80/"
      interval = 30
  }
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags = {
      Name = "demoELB"
  }
}

resource "aws_key_pair" "demokeypair" {
  key_name = "demokey"
  public_key = file(var.path_to_public_key)
}

output "Vlan_ELB_IP" {
  value = aws_elb.demoELB.dns_name
}

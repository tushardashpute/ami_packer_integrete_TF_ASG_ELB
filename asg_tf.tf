resource "aws_elb" "web_elb" {
  name = "web-elb"
  security_groups = [
    "${aws_security_group.testsg.id}"
  ]
 
  availability_zones = ["us-east-1a","us-east-1b"]
 
  cross_zone_load_balancing   = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}

resource "aws_launch_configuration" "as_conf" {
    name_prefix = "as_conf-"
    image_id = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    security_groups = [aws_security_group.testsg.id] 
    user_data = file("install_jenkins.sh")
    lifecycle {
        create_before_destroy = true
    }

    root_block_device {
        volume_type = "gp2"
        volume_size = "8"
    }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "terraform-asg"
  launch_configuration = aws_launch_configuration.as_conf.name
  min_size             = 2
  max_size             = 3
  availability_zones = ["us-east-1a","us-east-1b"]
  desired_capacity = 2
  force_delete = true
  health_check_grace_period = 300
  health_check_type = "EC2"
  load_balancers= [
      "${aws_elb.web_elb.id}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
        key = "Name"
        value = "ASG Instance"
        propagate_at_launch = true
    }
}
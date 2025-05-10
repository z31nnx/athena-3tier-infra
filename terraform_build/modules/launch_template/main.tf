# AMI to include in launch templates 

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Web launch template 
resource "aws_launch_template" "athena_web_lt" {
  name          = var.launch_template_names["web"]
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_types
  description   = "The web launch template for athena"

  vpc_security_group_ids = [var.athena_web_sg_id] # Athena VPC

  user_data = filebase64("${path.module}/web_userdata.sh") # Web userdata script 

  iam_instance_profile { # Instance profile with SSM/CloudWatch permission 
    name = var.ec2_instance_profile_name
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.default_tags, {
        Name = "${var.ec2_name}-web-instance"
      }
    )
  }
  tag_specifications {
    resource_type = "volume"
    tags = merge(
      local.default_tags, {
        Name = "${var.ec2_name}-web-volume"
      }
    )
  }

  tags = merge(
    local.default_tags, {
      Name = var.launch_template_names["web"]
    }
  )

  # Creates the templayte first before destroying 
  lifecycle {
    create_before_destroy = true
  }
}

# App launch template
resource "aws_launch_template" "athena_app_lt" {
  name          = var.launch_template_names["app"]
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_types
  description   = "The app launch template for athena"

  vpc_security_group_ids = [var.athena_app_sg_id] # Athena VPC

  user_data = filebase64("${path.module}/app_userdata.sh") # App userdata script 

  iam_instance_profile { # Instance profile with SSM/CloudWatch permission 
    name = var.ec2_instance_profile_name
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  monitoring {
    enabled = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.default_tags, {
        Name = "${var.ec2_name}-app-instance"
      }
    )
  }
  tag_specifications {
    resource_type = "volume"
    tags = merge(
      local.default_tags, {
        Name = "${var.ec2_name}-app-volume"
      }
    )
  }

  tags = merge(
    local.default_tags, {
      Name = var.launch_template_names["app"]
    }
  )

  # Creates the templayte first before destroying 
  lifecycle {
    create_before_destroy = true
  }
}
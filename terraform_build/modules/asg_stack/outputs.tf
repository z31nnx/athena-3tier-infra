output "asg_names" {
  value = {
    web = aws_autoscaling_group.athena_web_asg.name
    app = aws_autoscaling_group.athena_app_asg.name
  }
}
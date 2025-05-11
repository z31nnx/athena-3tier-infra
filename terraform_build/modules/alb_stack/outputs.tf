output "alb_dns_names" {
  value = {
    web = aws_lb.athena_web_alb.dns_name
    app = aws_lb.athena_app_alb.dns_name
  }
}

output "alb_target_group_arns" {
  value = {
    web = aws_lb_target_group.athena_web_alb_tg.arn
    app = aws_lb_target_group.athena_app_alb_tg.arn
  }
}
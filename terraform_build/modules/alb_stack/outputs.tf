output "alb_dns_names" {
  value = {
    web = aws_lb.athena_web_alb.dns_name
    app = aws_lb.athena_app_alb.dns_name
  }
}
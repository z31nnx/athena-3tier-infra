# IAM Role used for EC2 
resource "aws_iam_role" "athena_ops_role" {
  name = "athena-ops-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    local.default_tags, {
      Name = var.iam_role_name
    }
  )
}

# Policy attachmnent to athena ops role 
resource "aws_iam_role_policy_attachment" "athena_ops_role_policy_attachment" {
  for_each = var.iam_managed_policies

  role       = aws_iam_role.athena_ops_role.name
  policy_arn = each.value
}

# Instance profile for the EC2 
resource "aws_iam_instance_profile" "athena_ops_role_profile" {
  name = "athena_ops_role_profile"
  role = aws_iam_role.athena_ops_role.name

  tags = merge(local.default_tags, {
    Name = var.iam_instance_profile_name
  })
}



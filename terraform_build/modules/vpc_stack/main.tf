resource "aws_vpc" "athena_vpc" { # The VPC
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = merge(local.default_tags, { # Combines custom resource name with standard tags
    Name = "${var.vpc_name}-vpc"
  }) 
}

# The VPC's Internet Gateway which allows us to connect to the internet
resource "aws_internet_gateway" "athena_igw" {
  vpc_id = aws_vpc.athena_vpc.id

  tags = merge(local.default_tags, {
    Name = "${var.vpc_name}-igw"
  })
}

resource "aws_eip" "nat_eip" { # Elastic IP (EIP) for the NAT gateway
  domain = "vpc"

  tags = merge(local.default_tags, {
    Name = "${var.vpc_name}-natgw-eip"
  })
}

resource "aws_nat_gateway" "athena_natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id

  tags = merge(local.default_tags, {
    Name = "${var.vpc_name}-natgw"
  })
}

resource "aws_subnet" "public_subnets" {
  for_each = local.public_subnets # for_each which runs through all of the public_subnets 

  vpc_id                                      = aws_vpc.athena_vpc.id # Targets the athena VPC 
  cidr_block                                  = each.value.cidr_block # CIDR block in local.public_subnets "ex: 10.0.1.0/24"
  availability_zone                           = each.value.az         # The two availability zones inside the local.public_subnets
  map_public_ip_on_launch                     = true                  # Enables auto-assign public IPv4 
  enable_resource_name_dns_a_record_on_launch = true                  # Enables automatic DNS records for instances with names (rarely needed, mostly for DNS visibility)


  tags = merge(local.default_tags, {
    Name = "${var.vpc_name}-public-subnet-${each.value.az}"
  })
}

resource "aws_subnet" "private_subnets" {
  for_each = local.private_subnets

  vpc_id                                      = aws_vpc.athena_vpc.id
  cidr_block                                  = each.value.cidr_block
  availability_zone                           = each.value.az
  map_public_ip_on_launch                     = true
  enable_resource_name_dns_a_record_on_launch = true

  tags = merge(local.default_tags, {
    Name = "${var.vpc_name}-private-subnet-${each.value.az}"
  })
}

# The public route table to connect the public subnets
resource "aws_route_table" "athena_public_rt" {
  vpc_id = aws_vpc.athena_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.athena_igw.id
  }

  tags = merge(local.default_tags, {
    Name = "${var.vpc_name}-public-rt"
  })
}

# The private route table to connect the private subnets 
resource "aws_route_table" "athena_private_rt" {
  vpc_id = aws_vpc.athena_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.athena_natgw.id
  }

  tags = merge(local.default_tags, {
    Name = "${var.vpc_name}-private-rt"
  })
}

# Associates the public and private subnets to the corresponding route tables 
resource "aws_route_table_association" "athena_public_rt_association" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.athena_public_rt.id
}

resource "aws_route_table_association" "athena_private_rt_association" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.athena_private_rt.id
}

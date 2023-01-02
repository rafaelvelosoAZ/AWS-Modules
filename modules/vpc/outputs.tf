output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "subnet_public" {
  value = {
      for id, subnet in aws_subnet.public : id => subnet.id
    }
}

output "subnet_private" {
  value = {
      for id, subnet in aws_subnet.private : id => subnet.id
    }
}
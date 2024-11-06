resource "aws_internet_gateway" "this" {
  count  = length(var.public_subnets) > 0 ? 1 : 0
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-igw"
  }
}

resource "aws_internet_gateway" "this" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.this.id

  depends_on = [aws_subnet.public]

  tags = {
    "Name" = "${var.environment}-${var.component}-igw"
  }
}

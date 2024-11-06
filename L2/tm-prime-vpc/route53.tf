resource "aws_route53_zone" "private" {
  #checkov:skip=CKV2_AWS_39: "Ensure Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones"
  #checkov:skip=CKV2_AWS_38: "Ensure Domain Name System Security Extensions (DNSSEC) signing is enabled for Amazon Route 53 public hosted zones"
  count = (var.domain == "" || var.subdomain == "") ? 0 : 1

  name    = "${var.subdomain}.${var.domain}"
  comment = "Private hosted zone dedicated for ${var.component}"
  vpc {
    vpc_id = aws_vpc.this.id
  }
}

resource "aws_route53_zone" "public" {
  #checkov:skip=CKV2_AWS_39: "Ensure Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones"
  #checkov:skip=CKV2_AWS_38: "Ensure Domain Name System Security Extensions (DNSSEC) signing is enabled for Amazon Route 53 public hosted zones"
  count = (var.domain == "" || var.subdomain == "") ? 0 : 1

  name    = "${var.subdomain}.${var.domain}"
  comment = "Public hosted zone dedicated for ${var.component}"
}

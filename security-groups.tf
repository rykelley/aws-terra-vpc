
resource "aws_security_group" "default" {
  name = "aws-docker-default"
  description = " allows inbound and outbound "
  vpc_id = "${aws_vpc.default.id.}"

  ingress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    self = true
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    self = true
  }

  tags {
    name = "aws-docker-default"
  }

}

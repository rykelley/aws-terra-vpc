
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

/* Security group for the nat server */
resource "aws_security_group" "nat" {
  name = "nat-airpair-example"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet. Also allows outbound HTTP[S]"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 1194
      to_port = 1194
      protocol = "udp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  tags {
        Name = "nat-airpair-example"
  }

}

/* Security group for the web */

resource "aws_security_group" "web" {
  name = "docker-example"
  description = "Security group for web that allows web traffic from internet"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "web-airpair-example"
    }
  }

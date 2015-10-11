/* Internet gateway for the public subnet */

resource "aws_internet_gateway" "default"{
  vpc_id = ${aws_vpc.default.id}
}

/* create public subnet*/

resource "aws_subnet" "public" {

  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-west-1a"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.default"]
  tags {
    Name = "public"
  }
}

/* routing table for subnet*/

resource "aws_route_table" "public" {

  vpc_id = "${aws_vpc.default.id}"
  


}

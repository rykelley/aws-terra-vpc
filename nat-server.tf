/* NAt and vpn server build*/

resource "aws_instance" "nat" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.nat.id}"]
  key_name = "${aws_key_pair.deploy.key_name}"
  source_dest_check = false

  tags = {
    Name = "nat"
  }

  connection {
    user = "ubuntu"
    key_file = "ssh/deploy-key"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
      "echo 1 | sudo tee /proc/sys/net/ipv4/conf/all/forwarding > /dev/null",
      "curl -sSL https://get.docker.com/ubuntu/ | sudo sh",
      "sudo mkdir -p /etc/openvpn", "sudo docker run --name ovpn-data -v /etc/openvpn busybox",
      "sudo docker run --volumes-from ovpn-data --rm gosuri/openvpn ovpn_genconfig -p ${var.vpc_cidr} -u udp://${aws_instance.nat.public_ip}" ]
   }

}

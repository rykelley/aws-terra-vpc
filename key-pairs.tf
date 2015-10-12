resource "aws_key_pair" "deploy" {
  key-name = "deploy-key"
  public_key = "${file(\"ssh/deploy-key.pub\")}"

}

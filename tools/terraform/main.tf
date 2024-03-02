resource "aws_key_pair" "ec2_key" {
  key_name   = var.hostname
  public_key = file("../ssh/ec2.pub")
}
resource "aws_instance" "instance" {
  ami             = "ami-00e472d270763aaa3" # Standardize Image based on Ubuntu 22.04 LTS (64-bit (x86))
  key_name        = aws_key_pair.ec2_key.key_name
  instance_type   = "t2.small"
  security_groups = ["sg-0348948a9f025a14e"]
  subnet_id       = "subnet-b89e00e2"

  # user_data = templatefile("./init.tpl", {
  #   dd_api_key    = var.datadog_api_key
  #   hostname      = var.hostname
  #   frontend_repo = var.frontend
  #   backend_repo  = var.backend
  #   zendesk_repo  = var.zendesk
  # })

  provisioner "remote-exec" {
    inline = ["echo Waiting until SSH is ready"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("../ssh/ec2")
      host        = aws_instance.instance.private_ip
    }
  }

  tags = {
    Name = var.hostname
  }
}

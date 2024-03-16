resource "aws_key_pair" "ec2_key" {
  key_name   = var.hostname
  public_key = file("../ssh/ec2.pub")
}
resource "aws_instance" "instance" {
  # ami             = "ami-00e472d270763aaa3" # Standardize Image based on Ubuntu 22.04 LTS (64-bit (x86))

  # Standardize Image based on Ubuntu 22.04 LTS (64-bit (x86)) Default Language Versions Installed
  ami             = "ami-0141f0014370cc96d" 
  key_name        = aws_key_pair.ec2_key.key_name
  instance_type   = "t2.small"
  security_groups = ["sg-0348948a9f025a14e"]
  subnet_id       = "subnet-b89e00e2"

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

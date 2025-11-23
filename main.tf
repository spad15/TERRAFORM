resource "aws_vpc" "myterraform_VPC" {
  cidr_block = var.VPC_cidr_block
  enable_dns_hostnames=true
  tags = {
    Name = var.VPC_NAME
  }
}

resource "aws_subnet" "MyPublicsubnet_TFVPC"{
  vpc_id=aws_vpc.myterraform_VPC.id
  availability_zone=var.availability_zone
  cidr_block= var.Subnet_cidr_block
  map_public_ip_on_launch=true
  tags= {
    Name=var.SUbnet_NAME
  }
}
resource "aws_subnet" "MyPrivatesubnet_TFVPC"{
  vpc_id=aws_vpc.myterraform_VPC.id
  availability_zone=var.availability_zone
  cidr_block=var.private_subnet_cidr_block
  tags= {
    Name=var.Private_SUbnet_NAME
  }
}

resource "aws_route_table" "MypublicserverRT_TFVPC"{
  vpc_id=aws_vpc.myterraform_VPC.id
  tags={
    Name=var.Routetable_Public_name
    }
  route{ 
    cidr_block = var.route_cidrblock
    gateway_id = aws_internet_gateway.MyIGW_TFVPC.id
  }
  depends_on = [aws_internet_gateway.MyIGW_TFVPC] 
}
resource "aws_internet_gateway" "MyIGW_TFVPC" {
   vpc_id=aws_vpc.myterraform_VPC.id
tags = {
    Name =var.IGW_NAME
  }
}
resource "aws_route_table" "MyprivateserverRT_TFVPC"{
  vpc_id=aws_vpc.myterraform_VPC.id
  tags={
    Name=var.Routetable_Private_name
    }
}
resource "aws_route_table_association" "MyPublicsubnetAssoc_TFVPC" {
  subnet_id      = aws_subnet.MyPublicsubnet_TFVPC.id
  route_table_id = aws_route_table.MypublicserverRT_TFVPC.id

}
resource "aws_route_table_association" "MyPrivatesubnetAssoc_TFVPC" {
  subnet_id      = aws_subnet.MyPrivatesubnet_TFVPC.id
  route_table_id = aws_route_table.MyprivateserverRT_TFVPC.id
}

resource "aws_security_group" "mySG_TFVPC"{
   name        = var.Security_Group_name
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.myterraform_VPC.id

  tags = {
    Name = var.Security_Group_name
  }

}
resource "aws_vpc_security_group_ingress_rule" "mySGinboundtraffic_TFVPC" {
  security_group_id = aws_security_group.mySG_TFVPC.id
  cidr_ipv4         = var.route_cidrblock
  ip_protocol       = "-1"

}

resource "aws_vpc_security_group_egress_rule" "mySGoutboundtraffic_TFVPC" {
  security_group_id = aws_security_group.mySG_TFVPC.id
  cidr_ipv4         = var.route_cidrblock
  ip_protocol       = "-1" # semantically equivalent to all ports
}
resource "aws_key_pair" "mykeypair_TFVPC" {
  key_name   = var.key_pair_name
  public_key = var.Keypair_public_key
}
resource "aws_instance" "my_ec2_TFVPC" {
 ami= var.EC2_AMI_ID
  instance_type = var.EC2_instance_type
  key_name=aws_key_pair.mykeypair_TFVPC.key_name
  subnet_id      = aws_subnet.MyPublicsubnet_TFVPC.id
  associate_public_ip_address=true
vpc_security_group_ids = [aws_security_group.mySG_TFVPC.id]
   user_data = file("sh.sh")
tags = {
    Name = var.EC2_name
}
}
output "EC2_ID" {
  value=aws_instance.my_ec2_TFVPC.id
}
output "Keypairname" {
  value=aws_key_pair.mykeypair_TFVPC.key_name
}


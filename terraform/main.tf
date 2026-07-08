data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "movie_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Movie-VPC"
  }
}

resource "aws_subnet" "movie_subnet" {
  vpc_id                  = aws_vpc.movie_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Movie-Subnet"
  }
}

resource "aws_internet_gateway" "movie_igw" {
  vpc_id = aws_vpc.movie_vpc.id

  tags = {
    Name = "Movie-IGW"
  }
}

resource "aws_route_table" "movie_rt" {
  vpc_id = aws_vpc.movie_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.movie_igw.id
  }

  tags = {
    Name = "Movie-RouteTable"
  }
}

resource "aws_route_table_association" "movie_assoc" {
  subnet_id      = aws_subnet.movie_subnet.id
  route_table_id = aws_route_table.movie_rt.id
}

resource "aws_security_group" "movie_sg" {
  name   = "movie-security-group"
  vpc_id = aws_vpc.movie_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 5000
    to_port   = 5000
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Movie-SG"
  }
}

resource "aws_instance" "movie_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type

  key_name = "Assignment"
  
  subnet_id                   = aws_subnet.movie_subnet.id
  vpc_security_group_ids      = [aws_security_group.movie_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Movie-Recommendation-Server"
  }
}
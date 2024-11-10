#-------------------------------------------
#               LIFHEA 
#-------------------------------------------
resource "aws_instance" "lifhea" {
  ami                    = "ami-02668129cb45d0254" #data.aws_ami.ubuntu.image_id
  instance_type          = var.lifhea_ec2_instance_type
  key_name               = var.project
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.servers_sg.id]

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.lifhea_ec2_disk
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Name" = "Hipaa | Hosting | LIFHEA | Root"
    }
  }

  tags = merge(
    var.global_tags,
    {
      Name      = "Hipaa | Hosting | LIFHEA"
      Terraform = "true"
      Project   = var.project
  })
}

#-------------------------------------------
#               OMFINA
#-------------------------------------------
data "template_file" "omfina_user_data" {
  template = file("${path.module}/templates/install-ssm.sh")
  vars = {
    host = "hipaa-hosting-omfina"
  }
}

resource "aws_instance" "omfina" {
  ami                    = "ami-0212de136c7a67b0e" #data.aws_ami.ubuntu.image_id
  instance_type          = var.omfina_ec2_instance_type
  key_name               = var.project
  subnet_id              = module.vpc.private_subnets[3]
  vpc_security_group_ids = [aws_security_group.omfina_sg.id]
  user_data              = data.template_file.omfina_user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.omfina.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.omfina_ec2_disk
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Name" = "Hipaa | Hosting | OMFINA | Root"
    }
  }

  tags = {
    Name      = "Hipaa | Hosting | OMFINA"
    Terraform = "true"
    Project   = var.project
  }
}

resource "aws_ebs_volume" "omfina_ebs_volume" {
  count             = length(var.omfina_ebs_volume_names)
  availability_zone = aws_instance.omfina.availability_zone
  size              = element(var.omfina_ebs_volume_size, count.index)
  encrypted         = true
  type              = "gp3"
  tags = {
    Name                          = "Hipaa | Hosting | OMFINA | ${element(var.omfina_ebs_volume_tags, count.index)}"
    terraform_defined_mount_point = element(var.omfina_ebs_volume_mnt_paths, count.index)
  }
}

resource "aws_volume_attachment" "omfina_volume_attachement" {
  count       = length(var.omfina_ebs_volume_size)
  volume_id   = element(aws_ebs_volume.omfina_ebs_volume.*.id, count.index)
  device_name = element(var.omfina_ebs_volume_names, count.index)
  instance_id = aws_instance.omfina.id
}

#-------------------------------------------
#               NEWSEA
#-------------------------------------------
data "template_file" "newsea_user_data" {
  template = file("${path.module}/templates/user-data.sh")
  vars = {
    host = "hipaa-hosting-newsea"
  }
}

resource "aws_instance" "newsea" {
  ami                    = "ami-02668129cb45d0254" #data.aws_ami.ubuntu.image_id
  instance_type          = var.newsea_ec2_instance_type
  key_name               = var.project
  subnet_id              = module.vpc.private_subnets[3]
  vpc_security_group_ids = [aws_security_group.newsea_sg.id]
  user_data              = data.template_file.newsea_user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.newsea.name

  # Disable IMDSv1
  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
  }

  # Disable access to the metadata service
  # metadata_options {
  #   http_endpoint = "enabled"
  # }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.newsea_ec2_disk
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Name" = "Hipaa | Hosting | NEWSEA | Root"
    }
  }

  tags = {
    Name      = "Hipaa | Hosting | NEWSEA"
    Terraform = "true"
    Project   = var.project
  }
}

resource "aws_ebs_volume" "newsea_ebs_volume" {
  count             = length(var.newsea_ebs_volume_names)
  availability_zone = aws_instance.newsea.availability_zone
  size              = element(var.newsea_ebs_volume_size, count.index)
  encrypted         = true
  type              = "gp3"
  tags = {
    Name                          = "Hipaa | Hosting | NEWSEA | ${element(var.newsea_ebs_volume_tags, count.index)}"
    terraform_defined_mount_point = element(var.newsea_ebs_volume_mnt_paths, count.index)
  }
}

resource "aws_volume_attachment" "newsea_volume_attachement" {
  count       = length(var.newsea_ebs_volume_size)
  volume_id   = element(aws_ebs_volume.newsea_ebs_volume.*.id, count.index)
  device_name = element(var.newsea_ebs_volume_names, count.index)
  instance_id = aws_instance.newsea.id
}

#-------------------------------------------
#               RHAHEA
#-------------------------------------------
data "template_file" "rhahea_user_data" {
  template = file("${path.module}/templates/server-startup.sh")
  vars = {
    host = "hipaa-hosting-rhahea"
  }
}

resource "aws_instance" "rhahea" {
  ami                    = "ami-03f65b8614a860c29"
  instance_type          = var.rhahea_ec2_instance_type
  key_name               = var.project
  subnet_id              = module.vpc.private_subnets[1]
  vpc_security_group_ids = [aws_security_group.rhahea_sg.id]
  user_data              = data.template_file.rhahea_user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.rhahea.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.rhahea_ec2_disk
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Name" = "Hipaa | Hosting | RHAHEA | Root"
    }
  }

  tags = {
    Name      = "Hipaa | Hosting | RHAHEA"
    Terraform = "true"
    Project   = var.project
  }
}

resource "aws_ebs_volume" "rhahea_ebs_volume" {
  count             = length(var.rhahea_ebs_volume_names)
  availability_zone = aws_instance.rhahea.availability_zone
  size              = element(var.rhahea_ebs_volume_size, count.index)
  encrypted         = true
  type              = "gp3"
  tags = {
    Name                          = "Hipaa | Hosting | RHAHEA | ${element(var.rhahea_ebs_volume_tags, count.index)}"
    terraform_defined_mount_point = element(var.rhahea_ebs_volume_mnt_paths, count.index)
  }
}

resource "aws_volume_attachment" "rhahea_volume_attachement" {
  count       = length(var.rhahea_ebs_volume_size)
  volume_id   = element(aws_ebs_volume.rhahea_ebs_volume.*.id, count.index)
  device_name = element(var.rhahea_ebs_volume_names, count.index)
  instance_id = aws_instance.rhahea.id
}

#-------------------------------------------
#               ETHTHE
#-------------------------------------------
data "template_file" "eththe_user_data" {
  template = file("${path.module}/templates/server-startup.sh")
  vars = {
    host = "hipaa-hosting-eththe.fayebsg.prv"
  }
}

resource "aws_instance" "eththe" {
  ami                    = "ami-03f65b8614a860c29"
  instance_type          = var.eththe_ec2_instance_type
  key_name               = var.project
  subnet_id              = module.vpc.private_subnets[2]
  vpc_security_group_ids = [aws_security_group.eththe_sg.id]
  user_data              = data.template_file.eththe_user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.eththe.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.eththe_ec2_disk
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Name" = "Hipaa | Hosting | ETHTHE | Root"
    }
  }

  tags = {
    Name                               = "Hipaa | Hosting | ETHTHE"
    Terraform                          = "true"
    Project                            = var.project
    "terraform_defined_hosting_domain" = "fayehipaahosting"
  }
}

resource "aws_ebs_volume" "eththe_ebs_volume" {
  count             = length(var.eththe_ebs_volume_names)
  availability_zone = aws_instance.eththe.availability_zone
  size              = element(var.eththe_ebs_volume_size, count.index)
  encrypted         = true
  type              = "gp3"
  tags = {
    Name                          = "Hipaa | Hosting | ETHTHE | ${element(var.eththe_ebs_volume_tags, count.index)}"
    terraform_defined_mount_point = element(var.eththe_ebs_volume_mnt_paths, count.index)
  }
}

resource "aws_volume_attachment" "eththe_volume_attachement" {
  count       = length(var.eththe_ebs_volume_size)
  volume_id   = element(aws_ebs_volume.eththe_ebs_volume.*.id, count.index)
  device_name = element(var.eththe_ebs_volume_names, count.index)
  instance_id = aws_instance.eththe.id
}

#-------------------------------------------
#               NTCA
#-------------------------------------------
data "template_file" "ntca_user_data" {
  template = file("${path.module}/templates/server-startup.sh")
  vars = {
    host = "hipaa-hosting-ntca.fayebsg.prv"
  }
}

resource "aws_instance" "ntca" {
  ami                    = "ami-0b80a3fee1b46093a" #data.aws_ami.ubuntu.image_id
  instance_type          = var.ntca_ec2_instance_type
  key_name               = var.project
  subnet_id              = module.vpc.private_subnets[2]
  vpc_security_group_ids = [aws_security_group.ntca_sg.id]
  user_data              = data.template_file.ntca_user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.ntca.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.ntca_ec2_disk
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Name" = "Hipaa | Hosting | NTCA | Root"
    }
  }

  tags = {
    Name                               = "Hipaa | Hosting | NTCA"
    Terraform                          = "true"
    Project                            = var.project
    "terraform_defined_hosting_domain" = "fayehipaahosting"
  }
}

resource "aws_ebs_volume" "ntca_ebs_volume" {
  count             = length(var.ntca_ebs_volume_names)
  availability_zone = aws_instance.ntca.availability_zone
  size              = element(var.ntca_ebs_volume_size, count.index)
  encrypted         = true
  type              = "gp3"
  tags = {
    Name                          = "Hipaa | Hosting | NTCA | ${element(var.ntca_ebs_volume_tags, count.index)}"
    terraform_defined_mount_point = element(var.ntca_ebs_volume_mnt_paths, count.index)
  }
}

resource "aws_volume_attachment" "ntca_volume_attachement" {
  count       = length(var.ntca_ebs_volume_size)
  volume_id   = element(aws_ebs_volume.ntca_ebs_volume.*.id, count.index)
  device_name = element(var.ntca_ebs_volume_names, count.index)
  instance_id = aws_instance.ntca.id
}

#-------------------------------------------
#               CONMIN
#-------------------------------------------
data "template_file" "conmin_user_data" {
  template = file("${path.module}/templates/server-startup.sh")
  vars = {
    host = "hipaa-hosting-conmin.fayebsg.prv"
  }
}

resource "aws_instance" "conmin" {
  ami                    = "ami-0b80a3fee1b46093a" #data.aws_ami.ubuntu.image_id
  instance_type          = var.conmin_ec2_instance_type
  key_name               = var.project
  subnet_id              = module.vpc.private_subnets[2]
  vpc_security_group_ids = [aws_security_group.conmin_sg.id]
  user_data              = data.template_file.conmin_user_data.rendered
  iam_instance_profile   = aws_iam_instance_profile.conmin.name

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.conmin_ec2_disk
    encrypted             = true
    delete_on_termination = true
    tags = {
      "Name" = "Hipaa | Hosting | CONMIN | Root"
    }
  }

  tags = {
    Name                               = "Hipaa | Hosting | CONMIN"
    Terraform                          = "true"
    Project                            = var.project
    "terraform_defined_hosting_domain" = "fayehipaahosting"
  }
}

resource "aws_ebs_volume" "conmin_ebs_volume" {
  count             = length(var.conmin_ebs_volume_names)
  availability_zone = aws_instance.conmin.availability_zone
  size              = element(var.conmin_ebs_volume_size, count.index)
  encrypted         = true
  type              = "gp3"
  tags = {
    Name                          = "Hipaa | Hosting | CONMIN | ${element(var.conmin_ebs_volume_tags, count.index)}"
    terraform_defined_mount_point = element(var.conmin_ebs_volume_mnt_paths, count.index)
  }
}

resource "aws_volume_attachment" "conmin_volume_attachement" {
  count       = length(var.conmin_ebs_volume_size)
  volume_id   = element(aws_ebs_volume.conmin_ebs_volume.*.id, count.index)
  device_name = element(var.conmin_ebs_volume_names, count.index)
  instance_id = aws_instance.conmin.id
}
variable "aws_profile" {
  type        = string
  description = "aws cli profile"
}

variable "net_aws_profile" {
  type        = string
  description = "networking aws cli profile"
}

variable "aws_region" {
  type        = string
  description = "aws region where the infrastructure will be deployed"
}

variable "project" {
  type = string
}

variable "project_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "database_subnets" {
  type = list(string)
}

variable "global_tags" {
  type = map(string)
}

# RDS
#-------------------------------------------
#               RDS
#-------------------------------------------
variable "db_username" {
  type = string
}

variable "aurora_mysql_engine" {
  type = string
}

variable "aurora_mysql_engine_version" {
  type = string
}

variable "aurora_mysql_min_acu" {
  type = number
}

variable "aurora_mysql_max_acu" {
  type = number
}

# SG
variable "hipaa_bh_ips" {
  type = list(string)
}

# EC2
#-------------------------------------------
#               LIFHEA
#-------------------------------------------
variable "lifhea_ec2_disk" {
  type = string
}

variable "lifhea_ec2_instance_type" {
  type = string
}

#-------------------------------------------
#               VPN
#-------------------------------------------
variable "vpn_ec2_disk" {
  type = string
}

variable "vpn_ec2_instance_type" {
  type = string
}

#-------------------------------------------
#               OMFINA
#-------------------------------------------
variable "omfina_ec2_disk" {
  type = string
}

variable "omfina_ec2_instance_type" {
  type = string
}

variable "omfina_ebs_volume_names" {
  type = list(string)
}

variable "omfina_ebs_volume_size" {
  type = list(string)
}

variable "omfina_ebs_volume_tags" {
  type = list(string)
}

variable "omfina_ebs_volume_mnt_paths" {
  type = list(string)
}

#-------------------------------------------
#               NEWSEA
#-------------------------------------------
variable "newsea_ec2_disk" {
  type = string
}

variable "newsea_ec2_instance_type" {
  type = string
}

variable "newsea_ebs_volume_names" {
  type = list(string)
}

variable "newsea_ebs_volume_size" {
  type = list(string)
}

variable "newsea_ebs_volume_tags" {
  type = list(string)
}

variable "newsea_ebs_volume_mnt_paths" {
  type = list(string)
}

#-------------------------------------------
#               RHAHEA
#-------------------------------------------
variable "rhahea_ec2_disk" {
  type = string
}

variable "rhahea_ec2_instance_type" {
  type = string
}

variable "rhahea_ebs_volume_names" {
  type = list(string)
}

variable "rhahea_ebs_volume_size" {
  type = list(string)
}

variable "rhahea_ebs_volume_tags" {
  type = list(string)
}

variable "rhahea_ebs_volume_mnt_paths" {
  type = list(string)
}

#-------------------------------------------
#               ETHTHE
#-------------------------------------------
variable "eththe_ec2_disk" {
  type = string
}

variable "eththe_ec2_instance_type" {
  type = string
}

variable "eththe_ebs_volume_names" {
  type = list(string)
}

variable "eththe_ebs_volume_size" {
  type = list(string)
}

variable "eththe_ebs_volume_tags" {
  type = list(string)
}

variable "eththe_ebs_volume_mnt_paths" {
  type = list(string)
}

#-------------------------------------------
#               NTCA
#-------------------------------------------
variable "ntca_ec2_disk" {
  type = string
}

variable "ntca_ec2_instance_type" {
  type = string
}

variable "ntca_ebs_volume_names" {
  type = list(string)
}

variable "ntca_ebs_volume_size" {
  type = list(string)
}

variable "ntca_ebs_volume_tags" {
  type = list(string)
}

variable "ntca_ebs_volume_mnt_paths" {
  type = list(string)
}

#-------------------------------------------
#               CONMIN
#-------------------------------------------
variable "conmin_ec2_disk" {
  type = string
}

variable "conmin_ec2_instance_type" {
  type = string
}

variable "conmin_ebs_volume_names" {
  type = list(string)
}

variable "conmin_ebs_volume_size" {
  type = list(string)
}

variable "conmin_ebs_volume_tags" {
  type = list(string)
}

variable "conmin_ebs_volume_mnt_paths" {
  type = list(string)
}

# ACM
variable "domain" {
  type = string
}

variable "hipaa_domain" {
  type = string
}

#-------------------------------------------
#                  Opensearch
#-------------------------------------------
variable "os_engine_version" {
  type = string
}

variable "os_master_nodes" {
  type = number
}

variable "os_data_instance_type" {
  type = string
}

variable "os_data_isntance_count" {
  type = number
}

variable "os_zone_awareness_enabled" {
  type = bool
}

variable "os_ebs_enabled" {
  type = bool
}

variable "os_throughput" {
  type = number
}

variable "os_volume_type" {
  type = string
}

variable "os_ebs_volume_size" {
  type = number
}
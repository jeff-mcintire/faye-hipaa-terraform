aws_profile      = "hipaa-admin"
aws_region       = "us-west-2"
net_aws_profile = "networking-admin"
project          = "faye-hipaa"
project_id       = "hipaa"
vpc_cidr         = "10.121.0.0/16"
azs              = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
public_subnets   = ["10.121.1.0/24", "10.121.2.0/24", "10.121.3.0/24", "10.121.4.0/24"]
private_subnets  = ["10.121.9.0/28", "10.121.10.0/28", "10.121.11.0/28", "10.121.9.16/28"]
database_subnets = ["10.121.5.0/24", "10.121.6.0/24", "10.121.7.0/24", "10.121.8.0/24"]
global_tags = {
    project = "hipaa"
    backup = "yes"
} 

# rds
db_username                 = "fayedba"
aurora_mysql_engine         = "aurora-mysql"
aurora_mysql_engine_version = "8.0.mysql_aurora.3.05.2"
aurora_mysql_min_acu        = 1
aurora_mysql_max_acu        = 16

# SG
hipaa_bh_ips = ["10.9.139.23/32"]

# EC2
lifhea_ec2_disk          = "20"
lifhea_ec2_instance_type = "t3.large"
vpn_ec2_disk             = "20"
vpn_ec2_instance_type    = "t3.small"

#-------------------------------------------
#               OMFINA
#-------------------------------------------
omfina_ec2_disk          = "30"
omfina_ec2_instance_type = "t3.large"
omfina_ebs_volume_names  = ["/dev/sdf", "/dev/sdg", "/dev/sdh", "/dev/sdj"]
omfina_ebs_volume_size   = ["10", "10", "40", "20"]
omfina_ebs_volume_tags   = ["Logs", "Home", "Sugar", "Sugar Dev"]
omfina_ebs_volume_mnt_paths = ["/var/log", "/home", "/var/www/html/omfina", "/var/www/html/omfina-dev"]

#-------------------------------------------
#               NEWSEA
#-------------------------------------------
newsea_ec2_disk          = "30"
newsea_ec2_instance_type = "m6i.xlarge"
newsea_ebs_volume_names  = ["/dev/sdf", "/dev/sdg", "/dev/sdh"]
newsea_ebs_volume_size   = ["10", "10", "40"]
newsea_ebs_volume_tags   = ["Logs", "Home", "Sugar"]
newsea_ebs_volume_mnt_paths = ["/var/log", "/home", "/var/www/html/newsea"]

#-------------------------------------------
#               RHAHEA
#-------------------------------------------
rhahea_ec2_disk          = "30"
rhahea_ec2_instance_type = "t3.large"
rhahea_ebs_volume_names  = ["/dev/sdf", "/dev/sdg", "/dev/sdh"]
rhahea_ebs_volume_size   = ["10", "10", "40"]
rhahea_ebs_volume_tags   = ["Logs", "Home", "Sugar"]
rhahea_ebs_volume_mnt_paths = ["/var/log", "/home", "/var/www/html/rhahea"]

#-------------------------------------------
#               ETHTHE
#-------------------------------------------
eththe_ec2_disk          = "30"
eththe_ec2_instance_type = "t3.large"
eththe_ebs_volume_names  = ["/dev/sdf", "/dev/sdg", "/dev/sdh", "/dev/sdi"]
eththe_ebs_volume_size   = ["10", "10", "40", "20"]
eththe_ebs_volume_tags   = ["Logs", "Home", "Sugar", "Sugar Dev"]
eththe_ebs_volume_mnt_paths = ["/var/log", "/home", "/var/www/html/eththe", "/var/www/html/eththe-dev"]

#-------------------------------------------
#               NTCA
#-------------------------------------------
ntca_ec2_disk          = "30"
ntca_ec2_instance_type = "t4g.xlarge"
ntca_ebs_volume_names  = ["/dev/sdf", "/dev/sdg", "/dev/sdh", "/dev/sdi"]
ntca_ebs_volume_size   = ["10", "10", "50", "50"]
ntca_ebs_volume_tags   = ["Logs", "Home", "Sugar", "Sugar Staging"]
ntca_ebs_volume_mnt_paths = ["/var/log", "/home", "/var/www/html/ntca", "/var/www/html/ntca-staging"]

#-------------------------------------------
#               CONMIN
#-------------------------------------------
conmin_ec2_disk          = "30"
conmin_ec2_instance_type = "t4g.large"
conmin_ebs_volume_names  = ["/dev/sdf", "/dev/sdg", "/dev/sdh", "/dev/sdi"]
conmin_ebs_volume_size   = ["10", "10", "50", "10"]
conmin_ebs_volume_tags   = ["Logs", "Home", "Sugar", "Sugar Test"]
conmin_ebs_volume_mnt_paths = ["/var/log", "/home", "/var/www/html/conmin", "/var/www/html/conmin"]

# ACM
domain = "fbsghosting.com"
hipaa_domain = "fayehipaahosting.com"

#-------------------------------------------
#                  Opensearch
#-------------------------------------------
os_engine_version = "Elasticsearch_7.10"
os_master_nodes = 0
os_data_instance_type = "r5.large.search"
os_data_isntance_count = 3
os_zone_awareness_enabled = true

os_ebs_enabled = true
os_throughput = 125
os_volume_type = "gp3"
os_ebs_volume_size = 50

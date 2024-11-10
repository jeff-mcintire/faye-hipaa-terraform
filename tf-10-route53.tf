#-------------------------------------------
#               RHAHEA
#-------------------------------------------
resource "aws_route53_record" "rhahea_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "rhahea.${var.hipaa_domain}"
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "rhahea_dev_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "rhaheadev.${var.hipaa_domain}"
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "rhahealth_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "rhahealth.${var.hipaa_domain}"
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "rhahealthdev_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "rhahealthdev.${var.hipaa_domain}"
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

#-------------------------------------------
#               OMFINA
#-------------------------------------------
resource "aws_route53_record" "omfina_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "omfina.${var.hipaa_domain}"
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "omfina_dev_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "omfina-dev.${var.hipaa_domain}"
  type     = "A"
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

#-------------------------------------------
#               NEWSEA
#-------------------------------------------
resource "aws_route53_record" "newsea_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "newseason.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "newseason_test_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "newseasontest.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

#-------------------------------------------
#               ETHTHE
#-------------------------------------------
resource "aws_route53_record" "eththe_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "eththe.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "eththe_dev_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "eththe-dev.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

#-------------------------------------------
#               NTCA
#-------------------------------------------
resource "aws_route53_record" "ntca_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "ntca.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ntca_record_staging" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "ntca-staging.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ntca_prv" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.fayebsg_prv.zone_id
  name     = "hipaa-hosting-ntca.fayebsg.prv"
  type     = "A"
  ttl      = "300"
  records  = [aws_instance.ntca.private_ip]
}

#-------------------------------------------
#               CONMIN
#-------------------------------------------
resource "aws_route53_record" "conmin_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "conmin.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "conmin_test_record" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.hipaa_zone.zone_id
  name     = "conmin-test.${var.hipaa_domain}"
  type     = "A"
  # ttl     = "300"
  # records = [aws_lb.alb.dns_name]
  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "conmin_prv" {
  provider = aws.networking
  zone_id  = data.aws_route53_zone.fayebsg_prv.zone_id
  name     = "hipaa-hosting-conmin.fayebsg.prv"
  type     = "A"
  ttl      = "300"
  records  = [aws_instance.conmin.private_ip]
}
resource "aws_lb" "alb" {
  name                       = "${var.project}-alb"
  internal                   = false
  drop_invalid_header_fields = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = module.vpc.public_subnets

  enable_deletion_protection = true
  idle_timeout               = 300

  access_logs {
    bucket  = aws_s3_bucket.lb.id
    prefix  = "${var.project}-alb/accessLogs"
    enabled = true
  }

  connection_logs {
    bucket  = aws_s3_bucket.lb.id
    prefix  = "${var.project}-alb/connectionLogs"
    enabled = true
  }
}

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_acm_certificate.fbsghosting.arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Error"
      status_code  = "400"
    }
    # target_group_arn = aws_lb_target_group.lifhea_tg.arn
  }
}

#-------------------------------------------
#               LIFEHEA
#-------------------------------------------
resource "aws_lb_target_group" "lifhea_tg" {
  name        = "${var.project}-lifhea-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "lifehea_tg" {
  target_group_arn = aws_lb_target_group.lifhea_tg.arn
  target_id        = aws_instance.lifhea.id
  port             = 80
}

resource "aws_lb_listener_rule" "lifehea_tg" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lifhea_tg.arn
  }

  condition {
    host_header {
      values = ["lifenethealthcrm.${var.domain}", "lifenethealthcrm-dev.fbsghosting.com"]
    }
  }
}

#-------------------------------------------
#               OMFINA
#-------------------------------------------
resource "aws_lb_target_group" "omfina_tg" {
  name        = "${var.project}-omfina-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "omfina_tg" {
  target_group_arn = aws_lb_target_group.omfina_tg.arn
  target_id        = aws_instance.omfina.id
  port             = 80
}

resource "aws_lb_listener_rule" "omfina_tg" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.omfina_tg.arn
  }

  condition {
    host_header {
      values = ["omfina.${var.hipaa_domain}", "omfina-dev.${var.hipaa_domain}"]
    }
  }
}

#-------------------------------------------
#               NEWSEA
#-------------------------------------------
resource "aws_lb_target_group" "newsea_tg" {
  name        = "${var.project}-newsea-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "newsea_tg" {
  target_group_arn = aws_lb_target_group.newsea_tg.arn
  target_id        = aws_instance.newsea.id
  port             = 80
}

resource "aws_lb_listener_rule" "newsea_tg" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 4

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.newsea_tg.arn
  }

  condition {
    host_header {
      values = ["newseason.${var.hipaa_domain}", "newseasontest.${var.hipaa_domain}"]
    }
  }
}

#-------------------------------------------
#               RHAHEA
#-------------------------------------------
resource "aws_lb_target_group" "rhahea_tg" {
  name        = "${var.project}-rhahea-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "rhahea_tg" {
  target_group_arn = aws_lb_target_group.rhahea_tg.arn
  target_id        = aws_instance.rhahea.id
  port             = 80
}

resource "aws_lb_listener_rule" "rhahea_tg" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rhahea_tg.arn
  }

  condition {
    host_header {
      values = ["rhahea.${var.hipaa_domain}", "rhaheadev.${var.hipaa_domain}", "rhahealth.${var.hipaa_domain}", "rhahealthdev.${var.hipaa_domain}"]
    }
  }
}

#-------------------------------------------
#               ETHTHE
#-------------------------------------------
resource "aws_lb_target_group" "eththe_tg" {
  name        = "${var.project}-eththe-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "eththe_tg" {
  target_group_arn = aws_lb_target_group.eththe_tg.arn
  target_id        = aws_instance.eththe.id
  port             = 80
}

resource "aws_lb_listener_rule" "eththe_tg" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 7

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eththe_tg.arn
  }

  condition {
    host_header {
      values = ["eththe.fayehipaahosting.com", "eththe-dev.fayehipaahosting.com"]
    }
  }
}

#-------------------------------------------
#               NTCA
#-------------------------------------------
resource "aws_lb_target_group" "ntca_tg" {
  name        = "${var.project}-ntca-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "ntca_tg" {
  target_group_arn = aws_lb_target_group.ntca_tg.arn
  target_id        = aws_instance.ntca.id
  port             = 80
}

resource "aws_lb_listener_rule" "ntca_tg" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 8

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ntca_tg.arn
  }

  condition {
    host_header {
      values = ["ntca.fayehipaahosting.com", "ntca-staging.fayehipaahosting.com", "crm.ntca.org", "crm-stage.ntca.org"]
    }
  }
}

#-------------------------------------------
#               CONMIN
#-------------------------------------------
resource "aws_lb_target_group" "conmin_tg" {
  name        = "${var.project}-conmin-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "conmin_tg" {
  target_group_arn = aws_lb_target_group.conmin_tg.arn
  target_id        = aws_instance.conmin.id
  port             = 80
}

resource "aws_lb_listener_rule" "conmin_tg" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 9

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.conmin_tg.arn
  }

  condition {
    host_header {
      values = ["conmin-test.fayehipaahosting.com", "conmin.fayehipaahosting.com", "contact.sevocity.com"]
    }
  }
}
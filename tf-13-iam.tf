# ------------------------------------------------
# --------------- OMFINA  ------------------
# ------------------------------------------------

resource "aws_iam_instance_profile" "omfina" {
  name = "${var.project}-omfina-role"
  role = aws_iam_role.omfina.name
}

data "aws_iam_policy_document" "omfina" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "omfina" {
  name               = "${var.project}-omfina-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.omfina.json
}

resource "aws_iam_role_policy_attachment" "omfina" {
  role       = aws_iam_role.omfina.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

# data "aws_iam_policy_document" "omfina_policy" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:*"
#     ]
#     resources = [
#       aws_s3_bucket.omfina.arn,
#       "${aws_s3_bucket.omfina.arn}/*"
#     ]
#   }
# }

# resource "aws_iam_policy" omfina_policy {
#   name   = "${var.project}-omfina-policy"
#   policy = data.aws_iam_policy_document.omfina_policy.json
# }

# ------------------------------------------------
#                     NEWSEA  
# ------------------------------------------------

resource "aws_iam_instance_profile" "newsea" {
  name = "${var.project}-newsea-role"
  role = aws_iam_role.newsea.name
}

data "aws_iam_policy_document" "newsea" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "newsea" {
  name               = "${var.project}-newsea-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.newsea.json
}

resource "aws_iam_role_policy_attachment" "newsea" {
  role       = aws_iam_role.newsea.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "newsea_ec2_readonly" {
  role       = aws_iam_role.newsea.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# data "aws_iam_policy_document" "newsea_policy" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:*"
#     ]
#     resources = [
#       aws_s3_bucket.newsea.arn,
#       "${aws_s3_bucket.newsea.arn}/*"
#     ]
#   }

#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:*"
#     ]
#     resources = [
#       "arn:aws:s3:::faye-hipaa-user-data",
#       "arn:aws:s3:::faye-hipaa-user-data/*"
#     ]
#   }
# }

# resource "aws_iam_policy" newsea_policy {
#   name   = "${var.project}-newsea-policy"
#   policy = data.aws_iam_policy_document.newsea_policy.json
# }

# resource "aws_iam_role_policy_attachment" "newsea_policy" {
#   role       = aws_iam_role.newsea.name
#   policy_arn = aws_iam_policy.newsea_policy.arn #"arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
# }


# ------------------------------------------------
#                     RHAHEA  
# ------------------------------------------------

resource "aws_iam_instance_profile" "rhahea" {
  name = "${var.project}-rhahea-role"
  role = aws_iam_role.rhahea.name
}

data "aws_iam_policy_document" "rhahea" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "rhahea" {
  name               = "${var.project}-rhahea-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.rhahea.json
}

resource "aws_iam_role_policy_attachment" "rhahea" {
  role       = aws_iam_role.rhahea.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "rhahea_ec2_readonly" {
  role       = aws_iam_role.rhahea.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# ------------------------------------------------
#                     ETHTHE  
# ------------------------------------------------

resource "aws_iam_instance_profile" "eththe" {
  name = "${var.project}-eththe-role"
  role = aws_iam_role.eththe.name
}

data "aws_iam_policy_document" "eththe" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "eththe" {
  name               = "${var.project}-eththe-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eththe.json
}

resource "aws_iam_role_policy_attachment" "eththe" {
  role       = aws_iam_role.eththe.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "eththe_ec2_readonly" {
  role       = aws_iam_role.eththe.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# ------------------------------------------------
#                     NTCA  
# ------------------------------------------------

resource "aws_iam_instance_profile" "ntca" {
  name = "${var.project}-ntca-role"
  role = aws_iam_role.ntca.name
}

data "aws_iam_policy_document" "ntca" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ntca" {
  name               = "${var.project}-ntca-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ntca.json
}

resource "aws_iam_role_policy_attachment" "ntca" {
  role       = aws_iam_role.ntca.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "ntca_ec2_readonly" {
  role       = aws_iam_role.ntca.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# ------------------------------------------------
#                     CONMIN  
# ------------------------------------------------
resource "aws_iam_instance_profile" "conmin" {
  name = "${var.project}-conmin-role"
  role = aws_iam_role.conmin.name
}

data "aws_iam_policy_document" "conmin" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "conmin" {
  name               = "${var.project}-conmin-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.conmin.json
}

resource "aws_iam_role_policy_attachment" "conmin" {
  role       = aws_iam_role.conmin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "conmin_ec2_readonly" {
  role       = aws_iam_role.conmin.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
# ------------------------------------------------
#                    ALB logs 
# ------------------------------------------------
resource "aws_s3_bucket" "lb" {
  bucket = "${var.project}-lb-logs"
}

resource "aws_s3_bucket_policy" "lb" {
  bucket = aws_s3_bucket.lb.id

  policy = jsonencode(
    {
      Statement = [
        {
          Action = "s3:PutObject"
          Effect = "Allow"
          Principal = {
            AWS = "arn:aws:iam::${data.aws_elb_service_account.current.id}:root"
          }
          Resource = [
            "${aws_s3_bucket.lb.arn}/*"
          ]
        }
      ]
      Version = "2012-10-17"
    }
  )
}
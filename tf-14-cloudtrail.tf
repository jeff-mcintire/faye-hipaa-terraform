# resource "aws_cloudtrail" "cloudtrail" {
#   name           = "${var.project_id}-cloudtrail"
#   s3_bucket_name = aws_s3_bucket.cloudtrail_bucket.id
#   #   kms_key_id                    = "arn:aws:kms:eu-south-1:413698726086:key/12cd93b6-8b92-4323-a22f-9ef3c96481e1"
#   include_global_service_events = false
# }

# resource "aws_s3_bucket" "cloudtrail_bucket" {
#   bucket = "${var.project_id}-cloudtrail-logs"
# }

# resource "aws_s3_bucket_policy" "cloudtrail_bucket" {
#   bucket = aws_s3_bucket.cloudtrail_bucket.id
#   policy = <<POLICY
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "AWSCloudTrailAclCheck",
#             "Effect": "Allow",
#             "Principal": {
#               "Service": "cloudtrail.amazonaws.com"
#             },
#             "Action": "s3:GetBucketAcl",
#             "Resource": "${aws_s3_bucket.cloudtrail_bucket.arn}"
#         },
#         {
#             "Sid": "AWSCloudTrailWrite",
#             "Effect": "Allow",
#             "Principal": {
#               "Service": "cloudtrail.amazonaws.com"
#             },
#             "Action": "s3:PutObject",
#             "Resource": "${aws_s3_bucket.cloudtrail_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
#             "Condition": {
#                 "StringEquals": {
#                     "s3:x-amz-acl": "bucket-owner-full-control"
#                 }
#             }
#         }
#     ]
# }
# POLICY
# }
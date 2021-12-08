module "s3_bucket_module" {
  source = ""

  bucket = "Test"
  acl    = "private"

  versioning = {
    enabled = true
  }

}


module "iam_role" {
  source  = ""
  version = "~> 4.3"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  create_role = true

  role_name         = "Testrole"
  role_requires_mfa = true

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
  ]
  number_of_custom_role_policy_arns = 2
}

resource "aws_cloudfront_distribution" "Test" {

  origin {
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.Test.cloudfront_access_identity_path
    }
  }
}


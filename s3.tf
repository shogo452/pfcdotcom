variable "aws_s3_arn" {}
variable "aws_s3_bucket_name" {}

# バケットの作成
resource "aws_s3_bucket" "public" {
  bucket = var.aws_s3_bucket_name
  acl    = "public-read"

  cors_rule {
    allowed_origins = ["https://example.com"]
    allowed_methods = ["GET"]
    allowed_headers = ["*"]
    max_age_seconds = 3000
  }
}

# ブロックパブリックアクセス
resource "aws_s3_bucket_public_access_block" "public" {
  bucket                  = aws_s3_bucket.public.id
  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = false
  restrict_public_buckets = true
}

# バケットポリシーの設定
resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.public.id
  policy = data.aws_iam_policy_document.public.json
}

data "aws_iam_policy_document" "public" {
  statement {
    sid       = "Stmt1544152948221"
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["arn:aws:s3:::${var.aws_s3_bucket_name}"]

    principals {
      type        = "AWS"
      identifiers = [var.aws_s3_arn]
    }
  }
}

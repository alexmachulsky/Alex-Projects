# Configure the AWS Provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.aws_region
}

# Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "alexmachulsky-portfolio"
}

variable "domain_name" {
  description = "Custom domain name (optional)"
  type        = string
  default     = ""
}

# S3 Bucket for static website
resource "aws_s3_bucket" "portfolio" {
  bucket = var.bucket_name

  tags = {
    Name        = "Alex Machulsky Portfolio"
    Environment = "Production"
    Project     = "DevOps Portfolio"
  }
}

# S3 Bucket public access configuration
resource "aws_s3_bucket_public_access_block" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 Bucket policy for public read access
resource "aws_s3_bucket_policy" "portfolio" {
  bucket     = aws_s3_bucket.portfolio.id
  depends_on = [aws_s3_bucket_public_access_block.portfolio]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.portfolio.arn}/*"
      },
    ]
  })
}

# S3 Bucket website configuration
resource "aws_s3_bucket_website_configuration" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# S3 Bucket versioning
resource "aws_s3_bucket_versioning" "portfolio" {
  bucket = aws_s3_bucket.portfolio.id
  versioning_configuration {
    status = "Enabled"
  }
}

# CloudFront Distribution (Optional but recommended)
resource "aws_cloudfront_distribution" "portfolio" {
  count = var.domain_name != "" ? 1 : 0

  origin {
    domain_name = aws_s3_bucket_website_configuration.portfolio.website_endpoint
    origin_id   = "S3-${var.bucket_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = var.domain_name != "" ? [var.domain_name] : []

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${var.bucket_name}"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.domain_name == ""
    # For custom domain, you'd need to add SSL certificate
    # acm_certificate_arn = var.domain_name != "" ? aws_acm_certificate.cert[0].arn : null
    # ssl_support_method  = var.domain_name != "" ? "sni-only" : null
  }

  tags = {
    Name        = "Alex Machulsky Portfolio CDN"
    Environment = "Production"
  }
}

# Route 53 Hosted Zone (if using custom domain)
resource "aws_route53_zone" "portfolio" {
  count = var.domain_name != "" ? 1 : 0
  name  = var.domain_name

  tags = {
    Name = "Alex Machulsky Portfolio DNS"
  }
}

# Route 53 Record (if using custom domain)
resource "aws_route53_record" "portfolio" {
  count   = var.domain_name != "" ? 1 : 0
  zone_id = aws_route53_zone.portfolio[0].zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio[0].domain_name
    zone_id                = aws_cloudfront_distribution.portfolio[0].hosted_zone_id
    evaluate_target_health = false
  }
}

# Outputs
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.portfolio.bucket
}

output "website_url" {
  description = "Website URL"
  value       = "http://${aws_s3_bucket_website_configuration.portfolio.website_endpoint}"
}

output "cloudfront_url" {
  description = "CloudFront URL"
  value       = var.domain_name != "" ? "https://${aws_cloudfront_distribution.portfolio[0].domain_name}" : "Not configured"
}

output "custom_domain_url" {
  description = "Custom domain URL"
  value       = var.domain_name != "" ? "https://${var.domain_name}" : "Not configured"
}

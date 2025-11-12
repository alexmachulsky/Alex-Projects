# AWS S3 Static Website Deployment

This directory contains Terraform configuration to deploy your portfolio to AWS S3 as a static website.

## Prerequisites

1. **AWS Account** - Free tier eligible
2. **AWS CLI** installed and configured
3. **Terraform** installed

## Setup Steps

### 1. Configure AWS Credentials

```bash
# Install AWS CLI (if not installed)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Configure AWS credentials
aws configure
# Enter your AWS Access Key ID, Secret Access Key, and preferred region (us-east-1)
```

### 2. Deploy Infrastructure with Terraform

```bash
# Navigate to terraform directory
cd terraform

# Initialize Terraform
terraform init

# Plan the deployment (review what will be created)
terraform plan

# Apply the configuration (create resources)
terraform apply
# Type 'yes' when prompted
```

### 3. Setup GitHub Actions (Automated Deployment)

Add these secrets to your GitHub repository:

1. Go to GitHub → Your Repository → Settings → Secrets and variables → Actions
2. Add these secrets:
   - `AWS_ACCESS_KEY_ID`: Your AWS access key
   - `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
   - `S3_BUCKET_NAME`: `alexmachulsky-portfolio` (or your chosen name)
   - `CLOUDFRONT_DISTRIBUTION_ID`: (optional, for CDN cache invalidation)

### 4. Deploy Your Site

**Option A: Automatic (Recommended)**
- Push code to main branch → GitHub Actions deploys automatically

**Option B: Manual Deployment**
```bash
# From project root directory
aws s3 sync . s3://alexmachulsky-portfolio \
  --exclude "*.git*" \
  --exclude "docker*" \
  --exclude "Dockerfile" \
  --exclude "nginx.conf" \
  --exclude ".github/*" \
  --exclude "README.md" \
  --exclude "terraform/*" \
  --delete
```

## Costs

- **S3 Storage**: ~$0.001/month (under free tier)
- **Data Transfer**: Free for first 100GB/month
- **Requests**: ~$0.10/month for typical traffic
- **Total**: ~$0.50-2.00/month

## Custom Domain (Optional)

To use your own domain (e.g., alexmachulsky.com):

1. **Purchase domain** (Route 53 or external provider)
2. **Update Terraform variables**:
   ```bash
   terraform apply -var="domain_name=alexmachulsky.com"
   ```
3. **SSL Certificate** will be automatically handled by CloudFront

## Terraform Resources Created

- **S3 Bucket**: Static website hosting
- **S3 Bucket Policy**: Public read access
- **CloudFront Distribution**: Global CDN (if using custom domain)
- **Route 53 Zone**: DNS management (if using custom domain)

## URLs After Deployment

- **S3 Website**: `http://alexmachulsky-portfolio.s3-website-us-east-1.amazonaws.com`
- **CloudFront**: `https://[random-id].cloudfront.net` (if configured)
- **Custom Domain**: `https://alexmachulsky.com` (if configured)

## Clean Up (Destroy Resources)

```bash
cd terraform
terraform destroy
# Type 'yes' when prompted
```

## Troubleshooting

**Common Issues:**

1. **Bucket name already exists**: Change `bucket_name` in `main.tf`
2. **Access denied**: Check AWS credentials and permissions
3. **Website not loading**: Verify bucket policy and public access settings

**Useful Commands:**
```bash
# Check bucket contents
aws s3 ls s3://alexmachulsky-portfolio

# Test website
curl http://alexmachulsky-portfolio.s3-website-us-east-1.amazonaws.com
```
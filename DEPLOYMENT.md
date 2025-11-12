# Deployment Guide: Portfolio to AWS S3

## Quick Start (5 minutes)

### 1. Install Prerequisites
```bash
# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Terraform
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

### 2. Configure AWS
```bash
aws configure
# Enter your AWS credentials when prompted
```

### 3. Deploy with Terraform
```bash
cd terraform
terraform init
terraform apply
# Type 'yes' when prompted
```

### 4. Setup Automated Deployment
1. Go to your GitHub repository
2. Settings → Secrets and variables → Actions
3. Add these secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY` 
   - `S3_BUCKET_NAME`: `alexmachulsky-portfolio`

### 5. Deploy!
Push to main branch → Automatic deployment via GitHub Actions

## Your Portfolio URLs:
- **S3**: `http://alexmachulsky-portfolio.s3-website-us-east-1.amazonaws.com`
- **With CloudFront**: `https://[id].cloudfront.net`

## Total Cost: ~$0.50-1.00/month 💰

That's it! Your portfolio is now live on AWS! 🚀
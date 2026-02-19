# DevOps Portfolio Website 🚀

A modern, responsive portfolio website showcasing DevOps skills and projects, built with a complete CI/CD pipeline and containerized deployment.

## 🌐 Live Demo

- **Local**: http://localhost:8888
- **GitHub Repository**: https://github.com/alexmachulsky/Alex-Projects

## ✨ Features

- **Modern Design**: Dark theme with gradient effects, glassmorphism, and smooth animations
- **Responsive Layout**: Fully responsive design that works on all devices
- **Interactive UI**: Smooth scrolling, parallax effects, and 3D card animations
- **Containerized**: Docker-ready with Nginx web server
- **CI/CD Pipeline**: Automated testing, building, and deployment with GitHub Actions
- **Infrastructure as Code**: Terraform configuration for AWS S3 deployment
- **Security Scanning**: Integrated Trivy vulnerability scanner

## 🛠️ Tech Stack

### Frontend
- HTML5
- CSS3 (Custom animations, gradients, glassmorphism)
- Vanilla JavaScript (ES6+)
- Font Awesome Icons
- Google Fonts (Inter, Space Grotesk)

### DevOps & Infrastructure
- **Containerization**: Docker, Docker Compose
- **Web Server**: Nginx Alpine
- **CI/CD**: GitHub Actions
- **IaC**: Terraform
- **Cloud**: AWS S3, CloudFront (optional)
- **Security**: Trivy vulnerability scanning

## 🚀 Quick Start

### Using Docker (Recommended)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/alexmachulsky/Alex-Projects.git
   cd Alex-Projects
   ```

2. **Start the container**:
   ```bash
   docker compose up -d
   ```

3. **Access the website**:
   Open your browser and navigate to `http://localhost:8888`

4. **Stop the container**:
   ```bash
   docker compose down
   ```

### Manual Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/alexmachulsky/Alex-Projects.git
   cd Alex-Projects
   ```

2. **Serve the files**:
   - Using Python:
     ```bash
     python3 -m http.server 8888
     ```
   - Using Node.js:
     ```bash
     npx http-server -p 8888
     ```

3. **Access the website**:
   Open your browser and navigate to `http://localhost:8888`

## 📋 Technical Skills Showcased

### Cloud & Infrastructure
- AWS (EKS, EC2, S3, CloudFront, Route53, Secrets Manager, Lambda, RDS)
- Infrastructure as Code (Terraform)

### Containerization & Orchestration
- Docker & Docker Compose
- Kubernetes
- Helm Charts

### CI/CD & Automation
- GitHub Actions
- Jenkins
- ArgoCD (GitOps)

### Configuration Management
- Ansible
- Bash Scripting

### Programming
- Python
- Bash
- YAML

### Monitoring & Logging
- Prometheus
- Grafana
- ELK Stack (Elasticsearch, Kibana, Fluent Bit)

## 🏗️ Project Structure

```
Alex-Projects/
├── .github/
│   └── workflows/
│       ├── ci-cd.yml           # Main CI/CD pipeline
│       ├── docker-publish.yml  # Docker image publishing
│       └── deploy-s3.yml       # AWS S3 deployment
├── terraform/
│   ├── main.tf                 # AWS infrastructure config
│   └── README.md               # Terraform documentation
├── index.html                  # Main HTML structure
├── styles.css                  # Complete styling
├── script.js                   # Interactive features
├── Dockerfile                  # Docker image definition
├── docker-compose.yml          # Docker orchestration
├── nginx.conf                  # Nginx configuration
├── DEPLOYMENT.md               # Deployment guide
└── README.md                   # This file
```

## 🔄 CI/CD Pipeline

The GitHub Actions pipeline automatically:

1. **Lints** HTML, CSS, and JavaScript code
2. **Builds** Docker image
3. **Tests** the container
4. **Scans** for security vulnerabilities with Trivy
5. **Deploys** to GitHub Pages (optional)
6. **Publishes** Docker image to GitHub Container Registry

## 🌩️ AWS Deployment

Deploy to AWS S3 with CloudFront CDN using Terraform:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed deployment instructions.

## 🐳 Docker Commands

### Build the image
```bash
docker build -t portfolio-website .
```

### Run the container
```bash
docker run -d -p 8888:80 --name portfolio portfolio-website
```

### View logs
```bash
docker logs portfolio
```

### Stop and remove
```bash
docker stop portfolio
docker rm portfolio
```

## 📝 Customization

1. **Update Personal Information**: Edit `index.html` to add your details
2. **Modify Styles**: Customize colors and effects in `styles.css`
3. **Add Projects**: Add new project cards in the projects section
4. **Update Skills**: Modify the skills grid with your technologies

## 🔒 Security

- Regular dependency updates
- Trivy security scanning in CI/CD pipeline
- Minimal Docker image using Alpine Linux
- Security headers in Nginx configuration

## 📧 Contact

- **Email**: alexm051197@gmail.com
- **LinkedIn**: [Alex Machulsky](https://www.linkedin.com/in/alex-machulsky-/)
- **GitHub**: [alexmachulsky](https://github.com/alexmachulsky)

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Design inspiration from modern portfolio websites
- Font Awesome for icons
- Google Fonts for typography
- Docker and Nginx communities

---

**Built with ❤️ by Alex Machulsky**

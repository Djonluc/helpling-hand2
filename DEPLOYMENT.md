# SkillHands Deployment Guide

Complete deployment guide for the SkillHands service marketplace platform.

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Deployment Options](#deployment-options)
- [Environment Configuration](#environment-configuration)
- [Database Setup](#database-setup)
- [Security Configuration](#security-configuration)
- [Monitoring & Logging](#monitoring--logging)
- [Performance Optimization](#performance-optimization)
- [Troubleshooting](#troubleshooting)
- [Maintenance](#maintenance)

## 🌟 Overview

This guide covers deploying SkillHands to various environments, from local development to production. The platform supports multiple deployment strategies including Docker, traditional servers, and cloud platforms.

### Deployment Checklist

- [ ] Environment variables configured
- [ ] Database setup and migrations
- [ ] SSL certificates installed
- [ ] Payment gateways configured
- [ ] Email services configured
- [ ] Monitoring and logging setup
- [ ] Backup strategies implemented
- [ ] CI/CD pipeline configured

## 📋 Prerequisites

### System Requirements

- **Node.js**: 18.x or higher
- **PostgreSQL**: 14.x or higher
- **Memory**: Minimum 2GB RAM (4GB+ recommended)
- **Storage**: Minimum 10GB available space
- **Network**: Stable internet connection for external services

### Required Accounts

- **Database**: PostgreSQL hosting (local, cloud, or managed)
- **Authentication**: Replit Auth application
- **Payments**: Stripe account + FAC merchant account
- **Email**: SMTP provider (Gmail, SendGrid, etc.)
- **Domain**: Domain name with SSL certificate
- **Hosting**: Server or cloud platform

## 🚀 Deployment Options

### 1. Docker Deployment (Recommended)

#### Prerequisites

- Docker and Docker Compose installed
- Domain name configured
- SSL certificate (Let's Encrypt recommended)

#### Quick Start

```bash
# Clone repository
git clone <your-repo>
cd SkillHands

# Configure environment
cp .env.example .env
# Edit .env with production values

# Build and deploy
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f app
```

#### Production Docker Compose

```yaml
version: "3.8"
services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: skillhands_prod
      POSTGRES_USER: skillhands
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data
    restart: unless-stopped

  app:
    build: .
    ports:
      - "5000:5000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=${DATABASE_URL}
      - REDIS_URL=${REDIS_URL}
    depends_on:
      - postgres
      - redis
    volumes:
      - ./uploads:/app/uploads
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - app
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```

### 2. Traditional Server Deployment

#### Server Setup (Ubuntu 20.04+)

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Install Nginx
sudo apt install nginx

# Install PM2
sudo npm install -g pm2

# Install Redis
sudo apt install redis-server
```

#### Application Deployment

```bash
# Clone repository
git clone <your-repo> /var/www/skillhands
cd /var/www/skillhands

# Install dependencies
npm ci --production

# Build application
npm run build

# Configure environment
cp .env.example .env
# Edit .env with production values

# Run database migrations
npm run db:push

# Start with PM2
pm2 start dist/index.js --name skillhands
pm2 save
pm2 startup
```

#### Nginx Configuration

```nginx
server {
    listen 80;
    server_name your-domain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name your-domain.com;

    ssl_certificate /path/to/certificate.crt;
    ssl_certificate_key /path/to/private.key;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }

    # Static files
    location /uploads/ {
        alias /var/www/skillhands/uploads/;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
```

### 3. Cloud Platform Deployment

#### Vercel (Frontend)

```bash
# Install Vercel CLI
npm install -g vercel

# Deploy frontend
cd client
vercel --prod
```

#### Railway (Full Stack)

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login and deploy
railway login
railway init
railway up
```

#### Heroku

```bash
# Install Heroku CLI
# Create Procfile
echo "web: npm start" > Procfile

# Deploy
git add .
git commit -m "Deploy to Heroku"
git push heroku main
```

#### AWS/GCP Deployment

```bash
# Build Docker image
docker build -t skillhands .

# Push to container registry
docker tag skillhands:latest your-registry/skillhands:latest
docker push your-registry/skillhands:latest

# Deploy to Kubernetes or ECS
kubectl apply -f k8s/
```

## 🔧 Environment Configuration

### Production Environment Variables

```env
# Application
NODE_ENV=production
PORT=5000
BASE_URL=https://your-domain.com
FRONTEND_URL=https://your-domain.com

# Database
DATABASE_URL=postgresql://user:password@host:port/database
REDIS_URL=redis://localhost:6379

# Authentication
REPLIT_AUTH_URL=https://auth.replit.com
REPLIT_AUTH_CLIENT_ID=your_production_client_id
REPLIT_AUTH_CLIENT_SECRET=your_production_client_secret
REPLIT_AUTH_REDIRECT_URI=https://your-domain.com/auth/callback

# Session
SESSION_SECRET=your-super-secure-session-secret-change-this

# Payments
STRIPE_SECRET_KEY=sk_live_your_live_stripe_key
STRIPE_PUBLISHABLE_KEY=pk_live_your_live_stripe_key
FAC_MERCHANT_ID=your_production_fac_merchant_id
FAC_POWERTRANZ_ID=your_production_powertranz_id
FAC_POWERTRANZ_PASSWORD=your_production_powertranz_password
FAC_ENVIRONMENT=production
FAC_API_VERSION=2.8

# Email
SMTP_HOST=smtp.your-provider.com
SMTP_PORT=587
SMTP_USER=your-email@domain.com
SMTP_PASS=your-secure-password

# Security
ADMIN_EMAIL=admin@your-domain.com
MAX_FILE_SIZE=10485760
ALLOWED_FILE_TYPES=image/jpeg,image/png,image/gif,application/pdf

# Monitoring
LOG_LEVEL=info
SENTRY_DSN=your_sentry_dsn
```

### Environment-Specific Configs

```bash
# Development
cp .env.example .env.development

# Staging
cp .env.example .env.staging

# Production
cp .env.example .env.production
```

## 🗄️ Database Setup

### Local PostgreSQL

```bash
# Create database and user
sudo -u postgres psql

CREATE DATABASE skillhands_prod;
CREATE USER skillhands WITH PASSWORD 'your_secure_password';
GRANT ALL PRIVILEGES ON DATABASE skillhands_prod TO skillhands;
ALTER USER skillhands CREATEDB;
\q

# Test connection
psql -h localhost -U skillhands -d skillhands_prod
```

### Cloud Database (Neon, Supabase, etc.)

```bash
# Get connection string from cloud provider
# Example: postgresql://user:password@host:port/database

# Test connection
psql "postgresql://user:password@host:port/database"
```

### Database Migrations

```bash
# Push schema to database
npm run db:push

# Generate migration files
npm run db:generate

# Run migrations
npm run db:migrate
```

### Database Optimization

```sql
-- Add indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_professionals_user_id ON professionals(user_id);
CREATE INDEX idx_bookings_client_id ON bookings(client_id);
CREATE INDEX idx_bookings_professional_id ON bookings(professional_id);
CREATE INDEX idx_messages_sender_recipient ON messages(sender_id, recipient_id);
CREATE INDEX idx_reviews_professional_id ON reviews(professional_id);

-- Analyze table statistics
ANALYZE users;
ANALYZE professionals;
ANALYZE bookings;
ANALYZE messages;
ANALYZE reviews;
```

## 🛡️ Security Configuration

### SSL Certificate Setup

```bash
# Install Certbot
sudo apt install certbot python3-certbot-nginx

# Get SSL certificate
sudo certbot --nginx -d your-domain.com

# Auto-renewal
sudo crontab -e
# Add: 0 12 * * * /usr/bin/certbot renew --quiet
```

### Security Headers

```javascript
// server/security.ts
app.use(
  helmet({
    contentSecurityPolicy: {
      directives: {
        defaultSrc: ["'self'"],
        styleSrc: ["'self'", "'unsafe-inline'", "https://fonts.googleapis.com"],
        fontSrc: ["'self'", "https://fonts.gstatic.com"],
        imgSrc: ["'self'", "data:", "https:"],
        scriptSrc: ["'self'"],
        connectSrc: ["'self'", "wss:", "https:"],
        frameSrc: ["'none'"],
        objectSrc: ["'none'"],
      },
    },
    hsts: {
      maxAge: 31536000,
      includeSubDomains: true,
      preload: true,
    },
  })
);
```

### Rate Limiting

```javascript
// API rate limiting
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: "Too many requests from this IP, please try again later.",
  standardHeaders: true,
  legacyHeaders: false,
});

app.use("/api/", apiLimiter);
```

### Firewall Configuration

```bash
# UFW firewall setup
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
sudo ufw status
```

## 📊 Monitoring & Logging

### Application Monitoring

```bash
# Install monitoring tools
npm install -g clinic
npm install -g 0x

# Performance analysis
clinic doctor -- node dist/index.js

# Memory profiling
clinic heap -- node dist/index.js
```

### Log Management

```bash
# PM2 log management
pm2 logs skillhands
pm2 monit

# Log rotation
sudo logrotate -f /etc/logrotate.conf
```

### Health Checks

```javascript
// Health check endpoint
app.get("/api/health", (req, res) => {
  res.json({
    status: "healthy",
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    memory: process.memoryUsage(),
    database: "connected", // Add actual DB check
  });
});
```

### Error Tracking

```javascript
// Sentry integration
import * as Sentry from "@sentry/node";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: 1.0,
});

app.use(Sentry.Handlers.requestHandler());
app.use(Sentry.Handlers.errorHandler());
```

## ⚡ Performance Optimization

### Database Optimization

```sql
-- Connection pooling
-- Add to postgresql.conf
max_connections = 100
shared_buffers = 256MB
effective_cache_size = 1GB
work_mem = 4MB
maintenance_work_mem = 64MB
```

### Caching Strategy

```javascript
// Redis caching
import Redis from "ioredis";

const redis = new Redis(process.env.REDIS_URL);

// Cache professional profiles
app.get("/api/professionals/:id", async (req, res) => {
  const cacheKey = `professional:${req.params.id}`;
  const cached = await redis.get(cacheKey);

  if (cached) {
    return res.json(JSON.parse(cached));
  }

  const professional = await storage.getProfessional(req.params.id);
  await redis.setex(cacheKey, 300, JSON.stringify(professional)); // 5 min cache

  res.json(professional);
});
```

### CDN Setup

```nginx
# Nginx CDN configuration
location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
    add_header Vary Accept-Encoding;
}
```

### Load Balancing

```nginx
# Nginx load balancer
upstream skillhands_backend {
    server 127.0.0.1:5000;
    server 127.0.0.1:5001;
    server 127.0.0.1:5002;
}

server {
    location / {
        proxy_pass http://skillhands_backend;
    }
}
```

## 🔧 Troubleshooting

### Common Issues

#### 1. Database Connection Issues

```bash
# Check database status
sudo systemctl status postgresql

# Check connection
psql -h localhost -U skillhands -d skillhands_prod

# Check logs
sudo tail -f /var/log/postgresql/postgresql-15-main.log
```

#### 2. Memory Issues

```bash
# Monitor memory usage
pm2 monit
htop

# Restart if needed
pm2 restart skillhands
```

#### 3. SSL Certificate Issues

```bash
# Check certificate
openssl x509 -in certificate.crt -text -noout

# Renew Let's Encrypt
sudo certbot renew

# Check nginx config
sudo nginx -t
sudo systemctl reload nginx
```

#### 4. Payment Gateway Issues

```bash
# Check FAC configuration
curl -X GET "https://your-domain.com/api/fac/config" \
  -H "Authorization: Bearer <token>"

# Check Stripe configuration
curl -X GET "https://your-domain.com/api/health" \
  -H "Authorization: Bearer <token>"
```

### Debug Mode

```env
# Enable debug logging
NODE_ENV=development
LOG_LEVEL=debug
DEBUG=fac:*,payment:*,auth:*
```

### Performance Monitoring

```bash
# Monitor system resources
htop
iotop
nethogs

# Monitor application
pm2 monit
pm2 logs skillhands --lines 100
```

## 🔄 Maintenance

### Regular Tasks

```bash
# Daily
- Check application logs
- Monitor system resources
- Verify payment processing

# Weekly
- Review error logs
- Check database performance
- Update dependencies

# Monthly
- Security updates
- Performance optimization
- Backup verification
```

### Backup Strategy

```bash
# Database backup
pg_dump skillhands_prod > backup_$(date +%Y%m%d).sql

# File uploads backup
tar -czf uploads_$(date +%Y%m%d).tar.gz uploads/

# Automated backup script
#!/bin/bash
DATE=$(date +%Y%m%d)
pg_dump skillhands_prod > /backups/db_$DATE.sql
tar -czf /backups/uploads_$DATE.tar.gz uploads/
find /backups -name "*.sql" -mtime +7 -delete
find /backups -name "*.tar.gz" -mtime +7 -delete
```

### Update Process

```bash
# Pull latest changes
git pull origin main

# Install dependencies
npm ci --production

# Run migrations
npm run db:push

# Build application
npm run build

# Restart application
pm2 restart skillhands

# Verify deployment
curl https://your-domain.com/api/health
```

### Rollback Strategy

```bash
# Quick rollback
git checkout HEAD~1
npm ci --production
npm run build
pm2 restart skillhands

# Database rollback
psql skillhands_prod < backup_$(date +%Y%m%d).sql
```

---

## 📞 Support

For deployment issues:

- Check application logs
- Review server resources
- Verify environment configuration
- Contact system administrator
- Create GitHub issue

## 🎯 Next Steps

1. **Choose deployment method** based on your needs
2. **Set up environment** with production values
3. **Configure database** and run migrations
4. **Set up SSL** and security measures
5. **Deploy application** and verify functionality
6. **Set up monitoring** and alerting
7. **Configure backups** and maintenance tasks

---

**Note**: Always test deployments in a staging environment before deploying to production. Keep backups and have a rollback plan ready.

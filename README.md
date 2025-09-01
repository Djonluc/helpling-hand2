# SkillHands - Service Marketplace Platform

A mobile-first service marketplace app connecting verified skilled professionals with clients across Jamaica and the Caribbean.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Development](#development)
- [Testing](#testing)
- [Deployment](#deployment)
- [API Documentation](#api-documentation)
- [Security](#security)
- [Contributing](#contributing)
- [Support](#support)

## 🌟 Overview

SkillHands is a comprehensive service marketplace platform designed specifically for the Jamaican and Caribbean market. It connects skilled professionals (plumbers, electricians, carpenters, etc.) with clients who need their services, featuring advanced payment processing, professional verification, and real-time communication.

### Key Benefits

- **Local Focus**: Designed for Jamaican market with local payment gateways
- **Professional Verification**: Document-based verification system
- **Secure Payments**: Multiple payment options including FAC (First Atlantic Commerce)
- **Real-time Communication**: WebSocket-based chat system
- **Mobile-First**: Optimized for mobile devices
- **Admin Dashboard**: Complete platform management tools

## 🚀 Features

### Core Marketplace Features

- **User Authentication**: Secure login with Replit Auth
- **Professional Profiles**: Detailed profiles with ratings, reviews, and portfolios
- **Advanced Booking System**: Multi-step booking with payment processing
- **Payment Processing**:
  - Stripe integration
  - Jamaican payment gateways (NCB, Scotiabank, Lynk, Amber Pay)
  - First Atlantic Commerce (FAC) with 3DS support
  - Crypto payments (Binance)
- **Professional Verification**: Document upload and verification system
- **Real-time Messaging**: WebSocket-based chat system
- **Admin Dashboard**: Complete admin panel for platform management
- **Analytics & Tracking**: Comprehensive analytics and metrics
- **Ad System**: Freemium advertising platform
- **Push Notifications**: Email, SMS, and push notifications
- **File Upload System**: Secure file handling for documents and images

### Technical Features

- **Type Safety**: Full TypeScript implementation
- **Database**: PostgreSQL with Drizzle ORM
- **Testing**: Vitest + React Testing Library
- **Security**: Helmet, rate limiting, input validation
- **Performance**: Code splitting, bundle optimization
- **Deployment**: Docker, CI/CD with GitHub Actions

## 🛠️ Tech Stack

### Frontend

- **React 18** - Modern React with hooks and concurrent features
- **TypeScript** - Type-safe development
- **Vite** - Fast build tool and dev server
- **Tailwind CSS** - Utility-first CSS framework
- **shadcn/ui** - High-quality React components
- **Wouter** - Lightweight routing
- **TanStack Query** - Server state management
- **React Hook Form** - Form handling with Zod validation

### Backend

- **Express.js** - Fast, unopinionated web framework
- **TypeScript** - Type-safe Node.js development
- **WebSocket** - Real-time communication
- **Drizzle ORM** - Type-safe database operations
- **Passport.js** - Authentication middleware

### Database

- **PostgreSQL** - Robust, open-source database
- **Drizzle ORM** - Type-safe SQL query builder
- **Session Storage** - Redis-compatible session management

### Authentication & Payments

- **Replit Auth** - OpenID Connect authentication
- **Stripe** - International payment processing
- **First Atlantic Commerce (FAC)** - Caribbean payment gateway
- **Jamaican Gateways** - NCB, Scotiabank, Lynk, Amber Pay

### DevOps & Tools

- **Docker** - Containerization
- **GitHub Actions** - CI/CD pipeline
- **Vitest** - Unit testing framework
- **ESLint & Prettier** - Code quality tools

## 🏗️ Architecture

### Project Structure

```
SkillHands/
├── client/                 # React frontend application
│   ├── src/
│   │   ├── components/    # Reusable UI components
│   │   ├── pages/         # Page components
│   │   ├── hooks/         # Custom React hooks
│   │   ├── lib/           # Utilities and configurations
│   │   └── test/          # Test setup and utilities
│   ├── index.html         # HTML entry point
│   └── vite.config.ts     # Vite configuration
├── server/                # Express backend application
│   ├── routes.ts          # API route definitions
│   ├── storage.ts         # Database operations
│   ├── replitAuth.ts      # Authentication logic
│   ├── payment.ts         # Payment processing
│   ├── facPayment.ts      # FAC payment service
│   ├── notifications.ts   # Email/SMS notifications
│   ├── analytics.ts       # Analytics and tracking
│   ├── security.ts        # Security middleware
│   └── index.ts           # Server entry point
├── shared/                # Shared types and schemas
│   └── schema.ts          # Database schema definitions
├── migrations/            # Database migration files
├── uploads/               # File upload storage
├── .github/               # GitHub Actions workflows
├── Dockerfile             # Docker configuration
├── docker-compose.yml     # Docker Compose setup
└── package.json           # Project dependencies and scripts
```

### Database Schema

The application uses 12 main tables:

- **users** - User accounts and profiles
- **professionals** - Professional service providers
- **categories** - Service categories
- **bookings** - Service bookings and appointments
- **reviews** - Customer reviews and ratings
- **messages** - Real-time chat messages
- **favorites** - User favorite professionals
- **payment_transactions** - Payment records
- **verification_documents** - Professional verification
- **advertisements** - Ad system
- **professional_boosts** - Professional promotion
- **analytics_events** - User behavior tracking

## 🚀 Quick Start

### Prerequisites

- **Node.js 18+** - JavaScript runtime
- **PostgreSQL 14+** - Database server
- **npm or yarn** - Package manager

### 1. Clone and Install

```bash
git clone <your-repo>
cd SkillHands
npm install
```

### 2. Environment Setup

```bash
# Copy environment template
cp .env.example .env

# Edit with your configuration
nano .env
```

### 3. Database Setup

```bash
# Ensure PostgreSQL is running
# Update DATABASE_URL in .env

# Push schema to database
npm run db:push
```

### 4. Start Development

```bash
# Start development server
npm run dev

# Access the application:
# Frontend: http://localhost:3000
# Backend: http://localhost:5000
```

## 🔧 Configuration

### Environment Variables

#### Database Configuration

```env
DATABASE_URL=postgresql://username:password@localhost:5432/skillhands_dev
```

#### Authentication (Replit Auth)

```env
REPLIT_AUTH_URL=https://auth.replit.com
REPLIT_AUTH_CLIENT_ID=your_client_id_here
REPLIT_AUTH_CLIENT_SECRET=your_client_secret_here
REPLIT_AUTH_REDIRECT_URI=http://localhost:5000/auth/callback
```

#### Payment Processing

```env
# Stripe
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key
STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key

# First Atlantic Commerce (FAC)
FAC_MERCHANT_ID=your_fac_merchant_id
FAC_POWERTRANZ_ID=your_powertranz_id
FAC_POWERTRANZ_PASSWORD=your_powertranz_password
FAC_ENVIRONMENT=test
FAC_API_VERSION=2.8
```

#### Email Configuration

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password
```

#### Application Configuration

```env
NODE_ENV=development
PORT=5000
BASE_URL=http://localhost:5000
SESSION_SECRET=your-super-secret-session-key
```

### Service Setup

#### 1. Database Setup

1. Install PostgreSQL locally or use cloud service (Neon, Supabase)
2. Create database named `skillhands_dev`
3. Update `DATABASE_URL` in `.env`

#### 2. Authentication Setup

1. Create Replit Auth application
2. Set redirect URI to `http://localhost:5000/auth/callback`
3. Update auth credentials in `.env`

#### 3. Payment Setup

1. **Stripe**: Create account and get API keys
2. **FAC**: Apply for merchant account at [firstatlanticcommerce.com](https://firstatlanticcommerce.com)
3. Update payment credentials in `.env`

#### 4. Email Setup

1. Configure SMTP settings (Gmail, SendGrid, etc.)
2. Update email credentials in `.env`

## 💻 Development

### Available Scripts

```bash
# Development
npm run dev              # Start development server
npm run setup            # Initial development setup

# Building
npm run build            # Build for production
npm run check            # TypeScript type checking

# Testing
npm run test             # Run tests in watch mode
npm run test:run         # Run tests once
npm run test:coverage    # Run with coverage report

# Database
npm run db:push          # Push schema to database
npm run db:generate      # Generate migration files
npm run db:migrate       # Run database migrations
```

### Development Workflow

1. **Feature Development**:

   - Create feature branch
   - Implement changes
   - Add tests
   - Run linting and tests
   - Submit pull request

2. **Code Quality**:

   - TypeScript strict mode enabled
   - ESLint for code linting
   - Prettier for code formatting
   - Pre-commit hooks for quality checks

3. **Testing Strategy**:
   - Unit tests for components and utilities
   - Integration tests for API endpoints
   - E2E tests for critical user flows
   - Test coverage reporting

## 🧪 Testing

### Test Framework

- **Vitest** - Fast unit testing framework
- **React Testing Library** - Component testing utilities
- **jsdom** - DOM environment for tests

### Running Tests

```bash
# Run all tests
npm run test:run

# Run tests in watch mode
npm run test

# Generate coverage report
npm run test:coverage

# Run specific test file
npm run test -- Header.test.tsx
```

### Test Structure

```
client/src/test/
├── setup.ts              # Test environment setup
└── components/           # Component tests
    ├── Header.test.tsx
    └── SearchBar.test.tsx
```

## 🚀 Deployment

### Deployment Options

#### 1. Docker Deployment (Recommended)

```bash
# Build and run with Docker Compose
docker-compose up -d

# Or build custom image
docker build -t skillhands .
docker run -p 5000:5000 skillhands
```

#### 2. Traditional Server Deployment

```bash
# Install dependencies
npm ci --production

# Build application
npm run build

# Start production server
npm start
```

#### 3. Cloud Platform Deployment

- **Vercel** - Frontend deployment
- **Railway** - Full-stack deployment
- **Heroku** - Traditional hosting
- **AWS/GCP** - Enterprise hosting

### Production Checklist

- [ ] Set `NODE_ENV=production`
- [ ] Configure production database
- [ ] Set up SSL certificates
- [ ] Configure production payment keys
- [ ] Set up monitoring and logging
- [ ] Configure backup strategies
- [ ] Set up CI/CD pipeline

### Environment Variables for Production

```env
NODE_ENV=production
DATABASE_URL=postgresql://user:pass@host:port/db
STRIPE_SECRET_KEY=sk_live_...
FAC_ENVIRONMENT=production
SMTP_HOST=smtp.provider.com
```

## 📱 API Documentation

### Authentication Endpoints

```http
GET /api/auth/user          # Get current user
POST /api/auth/logout       # Logout user
```

### Professional Endpoints

```http
GET /api/professionals/featured     # Get featured professionals
GET /api/professionals/search       # Search professionals
GET /api/professionals/:id          # Get professional profile
POST /api/professionals             # Create professional profile
```

### Booking Endpoints

```http
POST /api/bookings                  # Create new booking
GET /api/bookings                   # Get user bookings
PUT /api/bookings/:id               # Update booking
DELETE /api/bookings/:id            # Cancel booking
```

### Payment Endpoints

```http
POST /api/payments                  # Process payment
POST /api/fac/payment              # FAC payment initiation
POST /api/fac/3ds-callback         # 3DS authentication callback
GET /api/fac/transaction/:id       # Get transaction status
POST /api/fac/refund               # Process refund
```

### Admin Endpoints

```http
GET /api/admin/users                # Get all users
PUT /api/admin/users/:id/verify     # Verify professional
GET /api/admin/analytics            # Get analytics data
```

### WebSocket Endpoints

```http
WS /ws                              # Real-time messaging
```

## 🛡️ Security

### Security Features

- **Authentication**: Session-based auth with Replit Auth
- **Authorization**: Role-based access control
- **Input Validation**: Zod schema validation
- **SQL Injection Protection**: ORM-based queries
- **XSS Prevention**: Input sanitization
- **CSRF Protection**: Token-based protection
- **Rate Limiting**: API request throttling
- **Security Headers**: Helmet middleware
- **File Upload Security**: Type and size validation

### Security Best Practices

1. **Environment Variables**: Never commit secrets to version control
2. **HTTPS**: Always use HTTPS in production
3. **Input Validation**: Validate all user inputs
4. **Authentication**: Implement proper session management
5. **Authorization**: Check permissions for all operations
6. **Logging**: Log security events and errors
7. **Updates**: Keep dependencies updated

## 🤝 Contributing

### Development Setup

1. Fork the repository
2. Clone your fork
3. Create feature branch
4. Install dependencies
5. Make changes
6. Run tests
7. Submit pull request

### Code Standards

- **TypeScript**: Strict mode enabled
- **ESLint**: Follow linting rules
- **Prettier**: Consistent code formatting
- **Testing**: Maintain test coverage
- **Documentation**: Update docs for changes

### Pull Request Process

1. **Description**: Clear description of changes
2. **Testing**: All tests must pass
3. **Linting**: No linting errors
4. **Documentation**: Update relevant docs
5. **Review**: Code review required

## 📊 Monitoring & Analytics

### Built-in Analytics

- **User Behavior**: Page views, clicks, conversions
- **Business Metrics**: Bookings, revenue, user growth
- **Performance**: Response times, error rates
- **Payment Analytics**: Success rates, gateway performance

### Monitoring Tools

- **Application Logs**: Structured logging
- **Error Tracking**: Error monitoring and alerting
- **Performance Monitoring**: Response time tracking
- **Health Checks**: System health monitoring

## 🆘 Support

### Getting Help

- **Documentation**: Check this README and related docs
- **Issues**: Create GitHub issue for bugs
- **Discussions**: Use GitHub Discussions for questions
- **Code Review**: Request code review for complex changes

### Common Issues

1. **Database Connection**: Check DATABASE_URL and PostgreSQL status
2. **Authentication**: Verify Replit Auth credentials
3. **Payment Issues**: Check payment gateway configuration
4. **Build Errors**: Ensure Node.js version compatibility

## 🎯 Roadmap

### Short Term (1-3 months)

- [ ] Enhanced mobile app experience
- [ ] Advanced search and filtering
- [ ] Professional scheduling system
- [ ] Multi-language support

### Medium Term (3-6 months)

- [ ] Mobile app (React Native)
- [ ] Advanced analytics dashboard
- [ ] AI-powered recommendations
- [ ] Subscription plans

### Long Term (6+ months)

- [ ] International expansion
- [ ] Advanced fraud detection
- [ ] Machine learning features
- [ ] Enterprise features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Replit** for authentication infrastructure
- **Stripe** for international payment processing
- **First Atlantic Commerce** for Caribbean payment solutions
- **Open Source Community** for amazing tools and libraries

---

**Built with ❤️ for the Jamaican and Caribbean service marketplace**

For questions, support, or contributions, please reach out through GitHub or contact the development team.

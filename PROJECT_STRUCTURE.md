# SkillHands Project Structure

Complete overview of the SkillHands service marketplace platform structure and organization.

## 📋 Table of Contents

- [Overview](#overview)
- [Root Directory](#root-directory)
- [Client Directory](#client-directory)
- [Server Directory](#server-directory)
- [Shared Directory](#shared-directory)
- [Configuration Files](#configuration-files)
- [Documentation](#documentation)
- [Development Tools](#development-tools)

## 🌟 Overview

SkillHands follows a modern, scalable architecture with clear separation of concerns between frontend, backend, and shared components. The project is organized to support rapid development, testing, and deployment.

### Architecture Principles

- **Separation of Concerns**: Clear boundaries between client, server, and shared code
- **Type Safety**: Full TypeScript implementation across all layers
- **Modular Design**: Reusable components and services
- **Testing First**: Comprehensive test coverage
- **Documentation Driven**: Well-documented code and APIs

## 📁 Root Directory

```
SkillHands/
├── 📁 client/                 # React frontend application
├── 📁 server/                 # Express backend application
├── 📁 shared/                 # Shared types and schemas
├── 📁 migrations/             # Database migration files
├── 📁 uploads/                # File upload storage
├── 📁 .github/                # GitHub Actions workflows
├── 📄 README.md               # Main project documentation
├── 📄 API_DOCUMENTATION.md    # Complete API reference
├── 📄 DEPLOYMENT.md           # Deployment guide
├── 📄 FAC_INTEGRATION.md      # FAC payment integration guide
├── 📄 PROJECT_STRUCTURE.md    # This file
├── 📄 package.json            # Project dependencies and scripts
├── 📄 package-lock.json       # Locked dependency versions
├── 📄 tsconfig.json           # TypeScript configuration
├── 📄 vite.config.ts          # Vite build configuration
├── 📄 tailwind.config.ts      # Tailwind CSS configuration
├── 📄 postcss.config.js       # PostCSS configuration
├── 📄 components.json         # shadcn/ui components config
├── 📄 drizzle.config.ts       # Database ORM configuration
├── 📄 .env                    # Environment variables
├── 📄 .env.example            # Environment template
├── 📄 .gitignore              # Git ignore patterns
├── 📄 Dockerfile              # Docker container configuration
├── 📄 docker-compose.yml      # Docker services orchestration
├── 📄 .dockerignore           # Docker ignore patterns
└── 📄 vitest.config.ts        # Testing configuration
```

## 🖥️ Client Directory

The client directory contains the React frontend application built with modern web technologies.

```
client/
├── 📁 src/                    # Source code
│   ├── 📁 components/         # Reusable UI components
│   │   ├── 📁 ui/            # shadcn/ui components
│   │   │   ├── 📄 accordion.tsx
│   │   │   ├── 📄 alert-dialog.tsx
│   │   │   ├── 📄 alert.tsx
│   │   │   ├── 📄 aspect-ratio.tsx
│   │   │   ├── 📄 avatar.tsx
│   │   │   ├── 📄 badge.tsx
│   │   │   ├── 📄 breadcrumb.tsx
│   │   │   ├── 📄 button.tsx
│   │   │   ├── 📄 calendar.tsx
│   │   │   ├── 📄 card.tsx
│   │   │   ├── 📄 carousel.tsx
│   │   │   ├── 📄 chart.tsx
│   │   │   ├── 📄 checkbox.tsx
│   │   │   ├── 📄 collapsible.tsx
│   │   │   ├── 📄 command.tsx
│   │   │   ├── 📄 context-menu.tsx
│   │   │   ├── 📄 dialog.tsx
│   │   │   ├── 📄 drawer.tsx
│   │   │   ├── 📄 dropdown-menu.tsx
│   │   │   ├── 📄 form.tsx
│   │   │   ├── 📄 hover-card.tsx
│   │   │   ├── 📄 input-otp.tsx
│   │   │   ├── 📄 input.tsx
│   │   │   ├── 📄 label.tsx
│   │   │   ├── 📄 menubar.tsx
│   │   │   ├── 📄 navigation-menu.tsx
│   │   │   ├── 📄 pagination.tsx
│   │   │   ├── 📄 popover.tsx
│   │   │   ├── 📄 progress.tsx
│   │   │   ├── 📄 radio-group.tsx
│   │   │   ├── 📄 resizable.tsx
│   │   │   ├── 📄 scroll-area.tsx
│   │   │   ├── 📄 select.tsx
│   │   │   ├── 📄 separator.tsx
│   │   │   ├── 📄 sheet.tsx
│   │   │   ├── 📄 sidebar.tsx
│   │   │   ├── 📄 skeleton.tsx
│   │   │   ├── 📄 slider.tsx
│   │   │   ├── 📄 switch.tsx
│   │   │   ├── 📄 table.tsx
│   │   │   ├── 📄 tabs.tsx
│   │   │   ├── 📄 textarea.tsx
│   │   │   ├── 📄 toast.tsx
│   │   │   ├── 📄 toaster.tsx
│   │   │   ├── 📄 toggle-group.tsx
│   │   │   └── 📄 tooltip.tsx
│   │   ├── 📄 BookingForm.tsx      # Booking form component
│   │   ├── 📄 CategoryGrid.tsx     # Service categories display
│   │   ├── 📄 ChatInterface.tsx    # Real-time chat interface
│   │   ├── 📄 Header.tsx           # Application header
│   │   ├── 📄 MobileBottomNav.tsx  # Mobile navigation
│   │   ├── 📄 ProfessionalCard.tsx # Professional profile card
│   │   └── 📄 SearchBar.tsx        # Search functionality
│   ├── 📁 hooks/              # Custom React hooks
│   │   ├── 📄 use-mobile.tsx  # Mobile detection hook
│   │   ├── 📄 use-toast.ts    # Toast notification hook
│   │   └── 📄 useAuth.ts      # Authentication hook
│   ├── 📁 lib/                # Utilities and configurations
│   │   ├── 📄 authUtils.ts    # Authentication utilities
│   │   ├── 📄 queryClient.ts  # TanStack Query client
│   │   └── 📄 utils.ts        # General utilities
│   ├── 📁 pages/              # Page components
│   │   ├── 📄 booking.tsx     # Booking page
│   │   ├── 📄 home.tsx        # Home page
│   │   ├── 📄 landing.tsx     # Landing page
│   │   ├── 📄 messages.tsx    # Messages page
│   │   ├── 📄 not-found.tsx   # 404 page
│   │   ├── 📄 professional-profile.tsx  # Professional profile
│   │   ├── 📄 profile.tsx     # User profile page
│   │   └── 📄 search.tsx      # Search results page
│   ├── 📁 test/               # Test setup and utilities
│   │   ├── 📄 setup.ts        # Test environment setup
│   │   └── 📄 components/     # Component tests
│   │       ├── 📄 Header.test.tsx
│   │       └── 📄 SearchBar.test.tsx
│   ├── 📄 App.tsx             # Main application component
│   ├── 📄 index.css           # Global styles
│   └── 📄 main.tsx            # Application entry point
├── 📄 index.html              # HTML entry point
└── 📄 vite.config.ts          # Vite configuration
```

### Client Architecture

- **Component-Based**: Modular, reusable UI components
- **State Management**: TanStack Query for server state
- **Routing**: Wouter for lightweight routing
- **Styling**: Tailwind CSS with shadcn/ui components
- **Forms**: React Hook Form with Zod validation
- **Testing**: Vitest + React Testing Library

## 🖥️ Server Directory

The server directory contains the Express.js backend application with comprehensive API endpoints and business logic.

```
server/
├── 📄 index.ts                # Server entry point
├── 📄 routes.ts               # API route definitions
├── 📄 storage.ts              # Database operations
├── 📄 replitAuth.ts           # Authentication middleware
├── 📄 payment.ts              # Payment processing service
├── 📄 facPayment.ts           # FAC payment gateway service
├── 📄 notifications.ts        # Email/SMS notification service
├── 📄 analytics.ts            # Analytics and tracking service
├── 📄 security.ts             # Security middleware
└── 📄 vite.ts                 # Vite server configuration
```

### Server Architecture

- **RESTful API**: Standard HTTP endpoints
- **WebSocket**: Real-time messaging support
- **Middleware**: Authentication, validation, security
- **Services**: Business logic separation
- **Database**: Drizzle ORM with PostgreSQL
- **Security**: Helmet, rate limiting, CORS

## 🔄 Shared Directory

The shared directory contains common types, schemas, and utilities used by both client and server.

```
shared/
└── 📄 schema.ts               # Database schema definitions
```

### Shared Components

- **Database Schema**: Drizzle ORM table definitions
- **Type Definitions**: Common TypeScript interfaces
- **Validation Schemas**: Zod validation schemas
- **Constants**: Application-wide constants

## 🗄️ Migrations Directory

Database migration files for schema evolution and version control.

```
migrations/
├── 📄 0001_initial.sql        # Initial schema
├── 📄 0002_add_users.sql      # User table addition
├── 📄 0003_add_professionals.sql  # Professional profiles
├── 📄 0004_add_bookings.sql   # Booking system
├── 📄 0005_add_payments.sql   # Payment transactions
├── 📄 0006_add_messages.sql   # Messaging system
├── 📄 0007_add_reviews.sql    # Review system
├── 📄 0008_add_verification.sql  # Professional verification
├── 📄 0009_add_ads.sql        # Advertising system
├── 📄 0010_add_boosts.sql     # Professional promotion
└── 📄 0011_add_analytics.sql  # Analytics tracking
```

## 📁 Uploads Directory

File storage for user uploads including profile images and verification documents.

```
uploads/
├── 📁 profile-images/         # User profile pictures
├── 📁 verification-docs/      # Professional verification documents
├── 📁 portfolio-images/       # Professional portfolio images
└── 📁 temp/                   # Temporary upload files
```

## 🔧 Configuration Files

### Package Configuration

- **package.json**: Project metadata, dependencies, and scripts
- **package-lock.json**: Locked dependency versions for consistency

### TypeScript Configuration

- **tsconfig.json**: TypeScript compiler options and paths
- **tsconfig.client.json**: Client-specific TypeScript config
- **tsconfig.server.json**: Server-specific TypeScript config

### Build Configuration

- **vite.config.ts**: Vite build tool configuration
- **tailwind.config.ts**: Tailwind CSS framework configuration
- **postcss.config.js**: PostCSS processing configuration

### Database Configuration

- **drizzle.config.ts**: Drizzle ORM configuration
- **.env**: Environment variables (not in version control)
- **.env.example**: Environment variables template

### Container Configuration

- **Dockerfile**: Docker container definition
- **docker-compose.yml**: Multi-service Docker orchestration
- **.dockerignore**: Docker build exclusions

### Testing Configuration

- **vitest.config.ts**: Vitest testing framework configuration

## 📚 Documentation

### Core Documentation

- **README.md**: Main project overview and quick start
- **API_DOCUMENTATION.md**: Complete API reference
- **DEPLOYMENT.md**: Deployment and production setup
- **FAC_INTEGRATION.md**: First Atlantic Commerce integration
- **PROJECT_STRUCTURE.md**: This file - project organization

### Documentation Standards

- **Markdown Format**: Consistent markdown structure
- **Code Examples**: Practical implementation examples
- **API References**: Complete endpoint documentation
- **Configuration Guides**: Step-by-step setup instructions

## 🛠️ Development Tools

### Code Quality

- **ESLint**: JavaScript/TypeScript linting
- **Prettier**: Code formatting
- **TypeScript**: Static type checking

### Testing Framework

- **Vitest**: Fast unit testing
- **React Testing Library**: Component testing
- **jsdom**: DOM environment for tests

### Build Tools

- **Vite**: Fast development and build tool
- **ESBuild**: Fast JavaScript bundler
- **PostCSS**: CSS processing pipeline

### Development Scripts

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

## 🚀 Deployment Structure

### Production Build

```
dist/                    # Production build output
├── 📄 index.js          # Server bundle
└── 📁 public/           # Static assets
    ├── 📄 index.html    # HTML entry point
    ├── 📁 assets/       # Compiled CSS and JS
    └── 📁 uploads/      # User uploads
```

### Docker Deployment

```
docker-compose.yml       # Service orchestration
├── postgres            # Database service
├── redis               # Cache service
├── app                 # Application service
└── nginx               # Web server service
```

## 📊 Project Metrics

### Code Statistics

- **Total Files**: 100+ source files
- **Lines of Code**: 10,000+ lines
- **Components**: 50+ React components
- **API Endpoints**: 30+ REST endpoints
- **Database Tables**: 12 main tables
- **Test Coverage**: 90%+ target

### Technology Stack

- **Frontend**: React 18, TypeScript, Vite, Tailwind CSS
- **Backend**: Express.js, TypeScript, WebSocket
- **Database**: PostgreSQL, Drizzle ORM
- **Authentication**: Replit Auth, Passport.js
- **Payments**: Stripe, First Atlantic Commerce
- **Testing**: Vitest, React Testing Library
- **Deployment**: Docker, GitHub Actions

## 🔄 Development Workflow

### 1. Feature Development

```
feature-branch → development → testing → review → main
```

### 2. Code Organization

- **Components**: Reusable UI components
- **Pages**: Route-specific components
- **Hooks**: Custom React hooks
- **Services**: Business logic services
- **Utilities**: Helper functions

### 3. Testing Strategy

- **Unit Tests**: Component and utility testing
- **Integration Tests**: API endpoint testing
- **E2E Tests**: User flow testing
- **Performance Tests**: Load and stress testing

## 🎯 Best Practices

### Code Organization

1. **Single Responsibility**: Each file has one clear purpose
2. **Consistent Naming**: Descriptive, consistent naming conventions
3. **Modular Structure**: Reusable, maintainable components
4. **Type Safety**: Full TypeScript implementation
5. **Documentation**: Comprehensive code documentation

### File Naming

- **Components**: PascalCase (e.g., `ProfessionalCard.tsx`)
- **Utilities**: camelCase (e.g., `authUtils.ts`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `API_ENDPOINTS`)
- **Types**: PascalCase (e.g., `UserProfile`)

### Import Organization

```typescript
// External libraries
import React from "react";
import { useQuery } from "@tanstack/react-query";

// Internal components
import { ProfessionalCard } from "@/components/ProfessionalCard";

// Utilities and types
import { useAuth } from "@/hooks/useAuth";
import type { Professional } from "@/types";
```

---

## 📞 Support

For questions about the project structure:

- Check the main README.md
- Review code comments
- Create GitHub issue
- Contact development team

## 🎯 Next Steps

1. **Explore Components**: Review the component structure
2. **Understand API**: Study the API documentation
3. **Set Up Development**: Follow the quick start guide
4. **Contribute**: Follow contribution guidelines
5. **Deploy**: Use the deployment guide

---

**Note**: This structure is designed for scalability and maintainability. All components follow established patterns and conventions for consistency across the codebase.

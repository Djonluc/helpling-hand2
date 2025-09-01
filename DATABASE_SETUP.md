# Database Setup Guide for SkillHands

Complete guide to set up PostgreSQL database for local development.

## 🚀 Quick Start (Windows)

### Option 1: Install PostgreSQL Locally

#### 1. Download PostgreSQL

- Visit [postgresql.org/download/windows](https://www.postgresql.org/download/windows/)
- Download PostgreSQL 15+ for Windows
- Run the installer

#### 2. Installation Steps

```bash
# During installation:
- Set password for postgres user: "password"
- Keep default port: 5432
- Install all components
```

#### 3. Verify Installation

```bash
# Open Command Prompt and test
psql --version
```

### Option 2: Use Docker (Recommended)

#### 1. Install Docker Desktop

- Download from [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)
- Install and restart computer

#### 2. Start PostgreSQL Container

```bash
# Open Command Prompt in project directory
docker run --name skillhands-postgres -e POSTGRES_PASSWORD=password -e POSTGRES_DB=skillhands_dev -p 5432:5432 -d postgres:15
```

#### 3. Verify Container

```bash
docker ps
# Should show postgres container running
```

## 🗄️ Database Setup

### 1. Create Database

```bash
# Connect to PostgreSQL
psql -U postgres -h localhost

# Create database
CREATE DATABASE skillhands_dev;

# Verify
\l

# Exit
\q
```

### 2. Test Connection

```bash
# Test with your .env settings
psql "postgresql://postgres:password@localhost:5432/skillhands_dev"

# Should connect successfully
# Exit with \q
```

### 3. Run Database Migrations

```bash
# In project directory
npm run db:push
```

## 🔧 Alternative: Use Cloud Database

### Option 1: Neon (Free Tier)

1. Visit [neon.tech](https://neon.tech)
2. Create account
3. Create new project
4. Copy connection string
5. Update `.env.development`:

```env
DATABASE_URL=postgresql://username:password@host:port/database
```

### Option 2: Supabase (Free Tier)

1. Visit [supabase.com](https://supabase.com)
2. Create account
3. Create new project
4. Get connection string from Settings > Database
5. Update `.env.development`

## 🧪 Test Database Connection

### 1. Update Environment

```bash
# Copy development environment
copy .env.development .env
```

### 2. Test Connection

```bash
# Run database check
npm run db:push
```

### 3. Verify Tables Created

```bash
# Connect to database
psql "postgresql://postgres:password@localhost:5432/skillhands_dev"

# List tables
\dt

# Should show tables like:
# - users
# - professionals
# - categories
# - bookings
# - etc.
```

## 🚨 Troubleshooting

### Common Issues

#### 1. Connection Refused

```bash
# Check if PostgreSQL is running
# Windows: Check Services app
# Docker: docker ps
```

#### 2. Authentication Failed

```bash
# Verify password in .env
# Check pg_hba.conf for authentication method
```

#### 3. Database Not Found

```bash
# Create database manually
CREATE DATABASE skillhands_dev;
```

#### 4. Permission Denied

```bash
# Grant permissions
GRANT ALL PRIVILEGES ON DATABASE skillhands_dev TO postgres;
```

## 📊 Database Schema

### Tables Created

- **users** - User accounts
- **professionals** - Professional profiles
- **categories** - Service categories
- **bookings** - Service bookings
- **reviews** - Customer reviews
- **messages** - Chat messages
- **favorites** - User favorites
- **payment_transactions** - Payment records
- **verification_documents** - Professional verification
- **advertisements** - Ad system
- **professional_boosts** - Professional promotion
- **analytics_events** - User behavior tracking

### Sample Data

```sql
-- Insert sample categories
INSERT INTO categories (id, name, icon, description) VALUES
('cat_1', 'Plumbing', '🔧', 'Plumbing and drainage services'),
('cat_2', 'Electrical', '⚡', 'Electrical installation and repair'),
('cat_3', 'Cleaning', '🧹', 'House and office cleaning'),
('cat_4', 'Carpentry', '🔨', 'Woodwork and repairs'),
('cat_5', 'Landscaping', '🌱', 'Garden and yard maintenance');
```

## 🚀 Next Steps

### 1. Verify Database

```bash
# Test connection
npm run db:push
```

### 2. Start Development

```bash
# Use the start script
start-dev.bat
```

### 3. Check Application

- Frontend: http://localhost:3000
- Backend: http://localhost:5000
- Database: Connected and working

## 📞 Support

### If You Get Stuck

1. **Check PostgreSQL logs**
2. **Verify connection string**
3. **Test with psql command**
4. **Check Windows Services**
5. **Restart Docker container**

### Useful Commands

```bash
# Check PostgreSQL status
sc query postgresql-x64-15

# Start PostgreSQL service
net start postgresql-x64-15

# Check Docker containers
docker ps

# View PostgreSQL logs
docker logs skillhands-postgres
```

---

**Note**: This guide assumes you're using Windows. For other operating systems, the commands may vary slightly.

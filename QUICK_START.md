# 🚀 Quick Start - SkillHands Preview

Get SkillHands running in 5 minutes for immediate preview!

## ⚡ **Option 1: Cloud Database (Recommended for Preview)**

### **Step 1: Get Free Cloud Database**

1. Visit [neon.tech](https://neon.tech) (free tier)
2. Sign up with GitHub/Google
3. Create new project: `skillhands-preview`
4. Copy connection string from dashboard

### **Step 2: Update Environment**

```bash
# Edit .env file and replace DATABASE_URL with your Neon connection string
DATABASE_URL=postgresql://username:password@host:port/database
```

### **Step 3: Start Preview**

```bash
npm run db:push
npm run dev
```

## 🗄️ **Option 2: Install PostgreSQL Locally**

### **Windows Installation**

1. Download from [postgresql.org/download/windows](https://www.postgresql.org/download/windows/)
2. Install with password: `password`
3. Keep default port: `5432`

### **Start Local Database**

```bash
# Create database
psql -U postgres -c "CREATE DATABASE skillhands_dev;"

# Test connection
psql "postgresql://postgres:password@localhost:5432/skillhands_dev"
```

## 🎯 **Option 3: Use the Start Script**

### **Run the Automated Setup**

```bash
# Double-click or run:
start-dev.bat
```

This will:

- ✅ Check prerequisites
- ✅ Install dependencies
- ✅ Configure environment
- ✅ Run tests
- ✅ Start development server

## 🌐 **Preview URLs**

Once running:

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000
- **Database**: Connected and working

## 🚨 **If You Get Stuck**

### **Common Issues & Solutions**

#### 1. Database Connection Failed

```bash
# Check if .env has correct DATABASE_URL
# Verify database is running
# Test connection manually
```

#### 2. Port Already in Use

```bash
# Change ports in .env
PORT=5001
# Frontend will auto-adjust
```

#### 3. Dependencies Missing

```bash
# Clean install
rm -rf node_modules package-lock.json
npm install
```

## 📱 **What You'll See**

### **Landing Page**

- Modern, mobile-first design
- Service categories grid
- Professional showcase
- Call-to-action buttons

### **User Features**

- User registration/login
- Professional profile creation
- Service booking system
- Payment integration (FAC + Stripe)
- Real-time chat
- Review system

### **Admin Panel**

- User management
- Professional verification
- Analytics dashboard
- Content moderation

## 🎉 **Success Indicators**

✅ **Database**: Tables created successfully  
✅ **Backend**: API responding on port 5000  
✅ **Frontend**: React app loading on port 3000  
✅ **Authentication**: Replit Auth working  
✅ **Payments**: FAC integration ready

---

## 🚀 **Ready to Start?**

Choose your preferred option above and let's get SkillHands previewing in minutes!

**Need help?** Check the detailed guides:

- [DATABASE_SETUP.md](./DATABASE_SETUP.md) - Complete database setup
- [README.md](./README.md) - Full project overview
- [PRODUCTION_CHECKLIST.md](./PRODUCTION_CHECKLIST.md) - Production roadmap

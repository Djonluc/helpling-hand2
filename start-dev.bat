@echo off
echo 🚀 Starting SkillHands Development Environment...
echo.

echo 📋 Checking prerequisites...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js not found! Please install Node.js 18+ first.
    pause
    exit /b 1
)

npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm not found! Please install npm first.
    pause
    exit /b 1
)

echo ✅ Node.js and npm found
echo.

echo 🔧 Installing dependencies...
call npm install
if %errorlevel% neq 0 (
    echo ❌ Failed to install dependencies
    pause
    exit /b 1
)

echo ✅ Dependencies installed
echo.

echo 🗄️ Setting up development environment...
if not exist ".env.development" (
    echo ❌ .env.development not found! Please create it first.
    pause
    exit /b 1
)

copy ".env.development" ".env" >nul
echo ✅ Environment configured
echo.

echo 🧪 Running tests...
call npm run test:run
if %errorlevel% neq 0 (
    echo ❌ Tests failed! Please fix issues before continuing.
    pause
    exit /b 1
)

echo ✅ All tests passed
echo.

echo 🚀 Starting development server...
echo.
echo 📱 Frontend: http://localhost:3000
echo 🔧 Backend:  http://localhost:5000
echo.
echo Press Ctrl+C to stop the server
echo.

call npm run dev

@echo off
echo 🚀 Starting SkillHands Preview Mode...
echo.

echo 🔧 Starting Backend Server...
start "SkillHands Backend" cmd /k "npx tsx server/index.ts"

echo ⏳ Waiting for backend to start...
timeout /t 3 /nobreak >nul

echo 📱 Starting Frontend...
start "SkillHands Frontend" cmd /k "npx vite --root client --port 3000 --host"

echo.
echo 🎉 SkillHands Preview Starting!
echo.
echo 📱 Frontend: http://localhost:3000
echo 🔧 Backend:  http://localhost:5001
echo.
echo Press any key to open the frontend...
pause >nul

start http://localhost:3000

echo.
echo 🌐 Opening SkillHands in your browser...
echo.
echo To stop the services, close the command windows
echo.
pause

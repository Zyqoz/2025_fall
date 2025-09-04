# CareConnect - Quick Start Guide

Get the CareConnect application running locally in just a few minutes!

## 🚀 Super Quick Start

### Prerequisites
- Java 17+
- Flutter SDK
- Chrome Browser

### 1. Clone & Setup
```bash
git clone [your-repo-url]
cd careconnect2025
```

### 2. Start Backend (Terminal 1)
```bash
./start-backend.sh
```
**Wait for**: "Started CareconnectBackendApplication"

### 3. Start Frontend (Terminal 2)  
```bash
./start-frontend.sh
```
**Wait for**: "Flutter run key commands"

### 4. Access Application
- **Frontend**: http://localhost:50030
- **Backend API**: http://localhost:8080

## 🧪 Test It Works

Create a test account:
```bash
curl -X POST http://localhost:8080/v1/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com", 
    "password": "password123",
    "role": "PATIENT"
  }'
```

Login with:
- **Email**: test@example.com
- **Password**: password123

## 📖 Need More Help?

See `LOCAL_DEVELOPMENT_SETUP.md` for:
- Detailed installation instructions
- Troubleshooting guide
- Development workflow
- Team collaboration tips

## ⚡ Development Tips

- **Backend changes**: Restart `./start-backend.sh`
- **Frontend changes**: Press `r` in Flutter terminal for hot reload
- **Database**: Check H2 console at http://localhost:8080/h2-console
- **API Testing**: Backend runs on port 8080

---
**Happy coding! 🎉**
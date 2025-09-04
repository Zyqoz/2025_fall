@echo off
echo 🚀 Starting CareConnect Backend in Development Mode
echo ==================================================

REM Check if we're in the right directory
if not exist "pom.xml" (
    echo ❌ Error: Please run this script from the backend\core directory
    pause
    exit /b 1
)

REM Check if Java is installed
java -version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Java is not installed. Please install Java 17 first.
    pause
    exit /b 1
)

REM Check if Maven is installed
mvn -version >nul 2>&1
if errorlevel 1 (
    echo ❌ Error: Maven is not installed. Please install Maven first.
    pause
    exit /b 1
)

echo ✅ Java and Maven found
echo ✅ Using H2 in-memory database
echo ✅ AWS services disabled
echo ✅ Mocked external service configurations
echo.

echo 🔧 Starting Spring Boot application...
echo 📊 H2 Console will be available at: http://localhost:8080/h2-console
echo 📚 API Documentation at: http://localhost:8080/swagger-ui.html
echo 🏥 Health check at: http://localhost:8080/actuator/health
echo.

REM Run the application with dev profile
mvnw.cmd spring-boot:run -Dspring-boot.run.profiles=dev

pause

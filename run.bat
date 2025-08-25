@echo off
echo ========================================
echo    CWebApp - .NET Web Application
echo ========================================
echo.

echo Checking .NET installation...
dotnet --version >nul 2>&1
if %errorlevel% neq 0 (
    echo .NET not found in PATH, trying to add common .NET installation paths...
    set "PATH=%PATH%;C:\Program Files\dotnet;C:\Program Files (x86)\dotnet"
    dotnet --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo ERROR: .NET SDK is not installed or not in PATH
        echo Please install .NET 8 SDK from: https://dotnet.microsoft.com/download
        pause
        exit /b 1
    )
)

echo .NET SDK found!
echo.

echo Restoring NuGet packages...
dotnet restore
if %errorlevel% neq 0 (
    echo ERROR: Failed to restore packages
    pause
    exit /b 1
)

echo Packages restored successfully!
echo.

echo Starting the application on port 5001...
echo.
echo The application will be available at:
echo - Web Interface: http://localhost:5001
echo - API Endpoints: http://localhost:5001/api/products
echo - Swagger Docs: http://localhost:5001/swagger
echo.
echo Press Ctrl+C to stop the application
echo.

dotnet run --urls "http://localhost:5001"

pause

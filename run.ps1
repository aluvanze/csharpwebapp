# CWebApp - .NET Web Application Launcher
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   CWebApp - .NET Web Application" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if .NET is available
Write-Host "Checking .NET installation..." -ForegroundColor Yellow
try {
    $dotnetVersion = dotnet --version
    Write-Host ".NET SDK found: $dotnetVersion" -ForegroundColor Green
} catch {
    Write-Host ".NET not found in PATH, trying to add common .NET installation paths..." -ForegroundColor Yellow
    $env:PATH += ";C:\Program Files\dotnet;C:\Program Files (x86)\dotnet"
    
    try {
        $dotnetVersion = dotnet --version
        Write-Host ".NET SDK found: $dotnetVersion" -ForegroundColor Green
    } catch {
        Write-Host "ERROR: .NET SDK is not installed or not in PATH" -ForegroundColor Red
        Write-Host "Please install .NET 8 SDK from: https://dotnet.microsoft.com/download" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

Write-Host ""

# Restore packages
Write-Host "Restoring NuGet packages..." -ForegroundColor Yellow
dotnet restore
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to restore packages" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Packages restored successfully!" -ForegroundColor Green
Write-Host ""

# Start the application
Write-Host "Starting the application on port 5001..." -ForegroundColor Yellow
Write-Host ""
Write-Host "The application will be available at:" -ForegroundColor Cyan
Write-Host "- Web Interface: http://localhost:5001" -ForegroundColor White
Write-Host "- API Endpoints: http://localhost:5001/api/products" -ForegroundColor White
Write-Host "- Swagger Docs: http://localhost:5001/swagger" -ForegroundColor White
Write-Host ""
Write-Host "Press Ctrl+C to stop the application" -ForegroundColor Yellow
Write-Host ""

dotnet run --urls "http://localhost:5001"

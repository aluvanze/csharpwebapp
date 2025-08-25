# Restart CWebApp - .NET Web Application
Write-Host "========================================" -ForegroundColor Magenta
Write-Host "   Restarting CWebApp..." -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Magenta
Write-Host ""

# Step 1: Stop the application
Write-Host "Step 1: Stopping the application..." -ForegroundColor Yellow

# Find and stop dotnet processes
$dotnetProcesses = Get-Process | Where-Object {$_.ProcessName -like "*dotnet*"}
if ($dotnetProcesses) {
    Write-Host "Stopping $($dotnetProcesses.Count) .NET process(es)..." -ForegroundColor Yellow
    $dotnetProcesses | Stop-Process -Force
    Write-Host "All .NET processes stopped!" -ForegroundColor Green
} else {
    Write-Host "No .NET processes found running." -ForegroundColor Green
}

# Check for processes using port 5001
$portProcesses = netstat -ano | findstr :5001 | findstr LISTENING
if ($portProcesses) {
    Write-Host "Stopping processes using port 5001..." -ForegroundColor Yellow
    foreach ($line in $portProcesses) {
        $parts = $line -split '\s+'
        $pid = $parts[-1]
        try {
            Stop-Process -Id $pid -Force
            Write-Host "Stopped process $pid" -ForegroundColor Green
        } catch {
            Write-Host "Could not stop process $pid" -ForegroundColor Red
        }
    }
}

# Wait a moment for processes to fully stop
Start-Sleep -Seconds 2

Write-Host ""
Write-Host "Step 2: Starting the application..." -ForegroundColor Yellow

# Step 2: Start the application
# Check if .NET is available
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

# Restore packages
Write-Host "Restoring NuGet packages..." -ForegroundColor Yellow
dotnet restore
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to restore packages" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Packages restored successfully!" -ForegroundColor Green

# Start the application
Write-Host ""
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

# Stop CWebApp - .NET Web Application
Write-Host "========================================" -ForegroundColor Red
Write-Host "   Stopping CWebApp..." -ForegroundColor Red
Write-Host "========================================" -ForegroundColor Red
Write-Host ""

# Find and stop dotnet processes
Write-Host "Looking for running .NET processes..." -ForegroundColor Yellow
$dotnetProcesses = Get-Process | Where-Object {$_.ProcessName -like "*dotnet*"}

if ($dotnetProcesses) {
    Write-Host "Found $($dotnetProcesses.Count) .NET process(es):" -ForegroundColor Yellow
    foreach ($process in $dotnetProcesses) {
        Write-Host "- Process ID: $($process.Id), Name: $($process.ProcessName)" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "Stopping .NET processes..." -ForegroundColor Yellow
    $dotnetProcesses | Stop-Process -Force
    Write-Host "All .NET processes stopped successfully!" -ForegroundColor Green
} else {
    Write-Host "No .NET processes found running." -ForegroundColor Green
}

# Check for processes using port 5001
Write-Host ""
Write-Host "Checking for processes using port 5001..." -ForegroundColor Yellow
$portProcesses = netstat -ano | findstr :5001 | findstr LISTENING

if ($portProcesses) {
    Write-Host "Found processes using port 5001:" -ForegroundColor Yellow
    foreach ($line in $portProcesses) {
        $parts = $line -split '\s+'
        $pid = $parts[-1]
        Write-Host "- Process ID: $pid" -ForegroundColor White
        try {
            Stop-Process -Id $pid -Force
            Write-Host "  Stopped process $pid" -ForegroundColor Green
        } catch {
            Write-Host "  Could not stop process $pid" -ForegroundColor Red
        }
    }
} else {
    Write-Host "No processes found using port 5001." -ForegroundColor Green
}

Write-Host ""
Write-Host "Application stopped successfully!" -ForegroundColor Green
Write-Host "You can now run '.\run.ps1' to start it again." -ForegroundColor Cyan

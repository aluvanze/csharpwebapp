@echo off
echo ========================================
echo    Packaging C# Web App for Sharing
echo ========================================
echo.

echo Creating clean package...
echo.

REM Create a temporary directory for packaging
if exist "CWebApp-Package" rmdir /s /q "CWebApp-Package"
mkdir "CWebApp-Package"

REM Copy essential files and folders
echo Copying source files...
xcopy "*.cs" "CWebApp-Package\" /Y
xcopy "*.csproj" "CWebApp-Package\" /Y
xcopy "*.json" "CWebApp-Package\" /Y
xcopy "*.md" "CWebApp-Package\" /Y
xcopy "*.ps1" "CWebApp-Package\" /Y
xcopy "*.bat" "CWebApp-Package\" /Y
xcopy "*.sql" "CWebApp-Package\" /Y

echo Copying folders...
xcopy "Controllers" "CWebApp-Package\Controllers\" /E /I /Y
xcopy "Models" "CWebApp-Package\Models\" /E /I /Y
xcopy "Services" "CWebApp-Package\Services\" /E /I /Y
xcopy "Data" "CWebApp-Package\Data\" /E /I /Y
xcopy "wwwroot" "CWebApp-Package\wwwroot\" /E /I /Y
xcopy "Properties" "CWebApp-Package\Properties\" /E /I /Y

REM Remove unnecessary files from package
echo Cleaning up package...
if exist "CWebApp-Package\package-for-sharing.bat" del "CWebApp-Package\package-for-sharing.bat"
if exist "CWebApp-Package\bin" rmdir /s /q "CWebApp-Package\bin"
if exist "CWebApp-Package\obj" rmdir /s /q "CWebApp-Package\obj"

echo.
echo Creating ZIP file...
powershell -command "Compress-Archive -Path 'CWebApp-Package\*' -DestinationPath 'CWebApp-Complete-Package.zip' -Force"

echo.
echo Cleaning up temporary files...
rmdir /s /q "CWebApp-Package"

echo.
echo ========================================
echo    Package Created Successfully!
echo ========================================
echo.
echo Your package is ready: CWebApp-Complete-Package.zip
echo.
echo This package includes:
echo - All source code files
echo - Configuration files
echo - Web interface
echo - Management scripts
echo - Documentation
echo.
echo Recipient needs:
echo - .NET 8 SDK
echo - MySQL/MariaDB database
echo - Visual Studio Code or Visual Studio
echo.
pause

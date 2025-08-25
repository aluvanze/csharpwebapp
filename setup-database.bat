@echo off
echo ========================================
echo    C# Web App Database Setup
echo ========================================
echo.

echo This script will help you set up the database for the C# Web App.
echo.

echo Choose your database setup method:
echo.
echo 1. Using XAMPP (MySQL)
echo 2. Using MySQL Command Line
echo 3. Using phpMyAdmin
echo 4. Manual setup instructions
echo.

set /p choice="Enter your choice (1-4): "

if "%choice%"=="1" goto xampp
if "%choice%"=="2" goto mysql
if "%choice%"=="3" goto phpmyadmin
if "%choice%"=="4" goto manual
goto invalid

:xampp
echo.
echo ========================================
echo    XAMPP MySQL Setup
echo ========================================
echo.
echo 1. Start XAMPP Control Panel
echo 2. Start Apache and MySQL services
echo 3. Open phpMyAdmin: http://localhost/phpmyadmin
echo 4. Create a new database called 'cwebapp'
echo 5. Import the database-setup.sql file
echo.
echo Or run this command in XAMPP MySQL:
echo mysql -u root -p < database-setup.sql
echo.
pause
goto end

:mysql
echo.
echo ========================================
echo    MySQL Command Line Setup
echo ========================================
echo.
echo Run this command in your terminal:
echo.
echo mysql -u your_username -p < database-setup.sql
echo.
echo Or connect to MySQL and run the script manually:
echo 1. mysql -u your_username -p
echo 2. source database-setup.sql;
echo.
pause
goto end

:phpmyadmin
echo.
echo ========================================
echo    phpMyAdmin Setup
echo ========================================
echo.
echo 1. Open phpMyAdmin in your browser
echo 2. Create a new database called 'cwebapp'
echo 3. Select the 'cwebapp' database
echo 4. Click on 'Import' tab
echo 5. Choose the 'database-setup.sql' file
echo 6. Click 'Go' to execute the script
echo.
pause
goto end

:manual
echo.
echo ========================================
echo    Manual Database Setup
echo ========================================
echo.
echo 1. Create a MySQL database named 'cwebapp'
echo 2. Run the SQL commands from database-setup.sql
echo 3. Update appsettings.json with your connection string
echo.
echo Connection string format:
echo "Server=localhost;Database=cwebapp;User=your_username;Password=your_password;"
echo.
pause
goto end

:invalid
echo.
echo Invalid choice. Please run the script again and choose 1-4.
echo.
pause
goto end

:end
echo.
echo ========================================
echo    Setup Instructions Complete
echo ========================================
echo.
echo After setting up the database:
echo 1. Update appsettings.json with your connection string
echo 2. Run the application: .\run.ps1
echo 3. Access the web interface: http://localhost:5001
echo.
pause

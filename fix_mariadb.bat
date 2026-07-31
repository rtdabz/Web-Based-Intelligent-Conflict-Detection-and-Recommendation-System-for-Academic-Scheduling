@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting Administrator Privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ============================================================
echo Repairing MariaDB Root Host Privileges...
echo ============================================================

echo 1. Stopping running mysqld process...
taskkill /F /IM mysqld.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo 2. Starting mysqld in --skip-grant-tables mode...
start "" "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini" --skip-grant-tables

echo 3. Waiting 4 seconds for server to start...
timeout /t 4 /nobreak >nul

echo 4. Repairing privileges...
"C:\xampp\mysql\bin\mysql.exe" -u root -e "FLUSH PRIVILEGES; CREATE USER IF NOT EXISTS 'root'@'localhost' IDENTIFIED BY ''; CREATE USER IF NOT EXISTS 'root'@'127.0.0.1' IDENTIFIED BY ''; GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION; GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' WITH GRANT OPTION; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo 5. Stopping temporary mysqld process...
taskkill /F /IM mysqld.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo 6. Restarting MariaDB server normally...
start "" "C:\xampp\mysql\bin\mysqld.exe" --defaults-file="C:\xampp\mysql\bin\my.ini"

echo ============================================================
echo DONE! MariaDB root privileges have been repaired.
echo ============================================================
pause

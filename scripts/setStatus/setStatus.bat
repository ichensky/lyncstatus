REM Change lync status using program `fortune` every 250 seconds  
REM To install fortune: 
REM 1. Install `cygwin`, cygwin `python2.7`
REM 2. python -m pip install fortune
REM 3. python -m fortune -u f.txt
REM

:loop
bash -c "LyncStatus/LyncStatus.exe -n ""$(fortune f.txt )"""
sleep 250
goto loop
pause

@ECHO off    
if /I %1 == server goto :server
if /I %1 == desktop goto :desktop
if /I %1 == import_server goto :import_server
if /I %1 == import_desktop goto :import_desktop
if /I %1 == help goto :usage

goto :usage ::can be ommited to run the `default` function similarly to makefiles

:clean
echo "Cleaning up previously built Images"
goto :eof

:server
call :clean
echo "Using Packer to build an Ubuntu Server image"
goto :eof

:desktop
call :clean
echo "Using Packer to build an Ubuntu Desktop image"
goto :eof

:import_server
echo "Importing and configuring the available server image"
goto :eof

:import_desktop
echo "Importing and configuring the available desktop image"
goto :eof

:usage
echo "Please run one of the avialable targets:"
echo "make.bat clean            Clean all generated instances"
echo "make.bat server           Build an Ubuntu Server Instance"
echo "make.bat desktop          Build an Ubuntu Desktop Instance"
echo "make.bat import_server    Import the created Ubuntu Server Image into VirtualBox"
echo "make.bat import_desktop   Import the created Ubuntu Desktop Image into VirtualBox"
echo "make.bat help             Show this information"
goto :eof
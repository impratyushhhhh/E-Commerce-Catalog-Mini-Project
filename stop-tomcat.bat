@echo off
setlocal
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 11.0"
set "CATALINA_BASE=%~dp0.tomcat"

echo Stopping Apache Tomcat 11...
"%CATALINA_HOME%\bin\catalina.bat" stop


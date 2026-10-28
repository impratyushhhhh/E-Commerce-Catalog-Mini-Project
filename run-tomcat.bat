@echo off
setlocal
set "JAVA_HOME=C:\Program Files\Java\jdk-25.0.2"
set "CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 11.0"
set "CATALINA_BASE=%~dp0.tomcat"

echo =========================================================================
echo Starting Apache Tomcat 11 with E-Commerce Catalog Application
echo Context URL: http://localhost:8080/ecommerce-catalog/
echo =========================================================================

"%CATALINA_HOME%\bin\catalina.bat" run


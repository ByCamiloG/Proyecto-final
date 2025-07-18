# Usa una imagen oficial de Tomcat con Java 17
FROM tomcat:10.1-jdk17-temurin

# Elimina las aplicaciones por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copia tu WAR generado por NetBeans (Ant) al contenedor
COPY dist/GildardoPeluqueria.war /usr/local/tomcat/webapps/ROOT.war

# Expone el puerto que Tomcat usará (Render lo mapea automáticamente)
EXPOSE 8080

# Ejecuta Tomcat al iniciar el contenedor
CMD ["catalina.sh", "run"]
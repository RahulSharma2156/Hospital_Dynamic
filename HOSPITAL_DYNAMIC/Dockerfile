FROM tomcat:10.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT/*

COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    /usr/local/tomcat/webapps/ROOT/WEB-INF/lib

RUN curl -L -o /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/mysql-connector-j.jar \
    https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.4.0/mysql-connector-j-9.4.0.jar

COPY HOSPITAL_DYNAMIC/src/main/java/ /tmp/java/

RUN javac \
    -cp "/usr/local/tomcat/lib/servlet-api.jar:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/mysql-connector-j.jar" \
    -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    $(find /tmp/java -name "*.java")

EXPOSE 8080

CMD sed -i "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml && catalina.sh run
FROM tomcat:9.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/ROOT

COPY . /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

CMD sh -c 'sed -i "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml && catalina.sh run'

FROM ubuntu:18.04
RUN apt-get -y update && apt-get -y upgrade
# Installing openjdk-11 in dockerfile
RUN apt-get -y install openjdk-11-jdk wget
#Installing Apache tomcat
RUN mkdir /usr/local/tomcat
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.36/bin/apache-tomcat-9.0.36.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.36/* /usr/local/tomcat/
#Adding the necessary configuration files
ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/project/
ADD settings.xml /usr/local/tomcat/conf/
ADD tomcat-users.xml /usr/local/tomcat/conf/
#Copying the web application to the tomcat server
COPY ./ServletCalci.war /usr/local/tomcat/webapps/
#Exposing default port
EXPOSE 8080
#Starting the working process
CMD /usr/local/tomcat/bin/catalina.sh run

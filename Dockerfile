FROM tomcat:9.0-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

# Download WAR directly from GitHub Release
RUN curl -L -o /usr/local/tomcat/webapps/ROOT.war \
    https://github.com/gowthamsrinivasan812/StudentCouncilElection/releases/download/v1/voting.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

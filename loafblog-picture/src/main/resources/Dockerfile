FROM 8-alpine
VOLUME /tmp
ADD loafblog-picture-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-Xms100m","-Xmx100m","-jar","/app.jar"]
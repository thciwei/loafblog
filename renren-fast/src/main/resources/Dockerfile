FROM java:8-alpine
EXPOSE 8080

VOLUME /tmp
ADD renren-fast.jar  app.jar
ENTRYPOINT ["java","-Xms100m","-Xmx100m","-jar","/app.jar"]

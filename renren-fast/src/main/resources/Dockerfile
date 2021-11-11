FROM java:alpine
EXPOSE 8080

VOLUME /tmp
ADD renren-fast.jar  /app.jar
RUN bash -c 'touch /app.jar'
ENTRYPOINT ["java","-Xms100m","-Xmx100m","-jar","/app.jar"]

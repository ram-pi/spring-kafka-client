#
# Build stage
#
FROM azul/zulu-openjdk-alpine:17-latest AS build
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package -DskipTests=true


FROM azul/zulu-openjdk-alpine:17-latest
COPY ./target/app.jar app.jar
#CMD ["java", "-javaagent:jmx_prometheus_javaagent-0.20.0.jar=9191:prometheus_config.yml", "-jar", "app.jar", "--spring.config.location", "application.properties"]
CMD ["java", "-jar", "app.jar"]
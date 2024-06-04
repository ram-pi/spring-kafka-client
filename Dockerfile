#
# Build stage
#
FROM maven:3.9.7-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17.0.11_9-jre-ubi9-minimal
#FROM azul/zulu-openjdk-debian:17-jre-latest
WORKDIR /app
COPY --from=build /app/target/app.jar .
CMD ["java", "-jar", "app.jar"]
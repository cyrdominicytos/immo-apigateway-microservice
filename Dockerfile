# Étape de build
FROM maven:3.9.8-eclipse-temurin-21-alpine AS build
WORKDIR /home/immo/apigateway
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Étape de run
FROM eclipse-temurin:21-alpine
WORKDIR /app
COPY --from=build /home/immo/apigateway/target/*.jar /app/apigateway.jar

EXPOSE 4000
ENTRYPOINT ["java","-jar","apigateway.jar"]

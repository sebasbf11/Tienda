#Etapa 1: Compilacion
FROM maven:3.8.5-openjdk-17 as build
workdir /app
copy . .
run mvn -f pom.xml clean package -DskipTest


#Etapa 2: Creacion de la imagen final
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
expose 80
entrypoint ["java","-jar", "app.jar"]
# Step 1: Build the Application
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY FoodApp/pom.xml FoodApp/
COPY FoodApp/src FoodApp/src
RUN mvn clean package -DskipTests

# Step 2: Runtime image using Tomcat 10.1
FROM tomcat:10.1-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/FoodApp/target/FoodApp.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

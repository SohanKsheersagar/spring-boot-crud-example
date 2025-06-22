# -------- Stage 1: Build the JAR using Maven --------
FROM maven:3.9.4-eclipse-temurin-17 AS builder

WORKDIR /app
COPY . .

# Build the project, skip tests
RUN mvn clean package -DskipTests

# -------- Stage 2: Run the JAR --------
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

# Expose the app port (your app runs on 9191)
EXPOSE 9191

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]

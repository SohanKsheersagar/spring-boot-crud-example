# -------- Stage 1: Build --------
FROM maven:3.9-eclipse-temurin-11 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# -------- Stage 2: Run --------
FROM eclipse-temurin:11-jdk
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 9191
ENTRYPOINT ["java", "-jar", "app.jar"]

# Step 1: Use a lightweight Java 17 runtime environment
FROM eclipse-temurin:17-jdk-alpine

# Step 2: Set the folder inside the container where commands will run
WORKDIR /app

# Step 3: Copy the compiled jar file from your target folder into the container
COPY app/target/*.jar app.jar

# Step 4: Tell the container to launch your Spring Boot app when it boots-up
ENTRYPOINT ["java", "-jar", "app.jar"]
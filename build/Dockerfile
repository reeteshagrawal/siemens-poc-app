# Step 1: Use a lightweight Java 21 runtime environment
FROM eclipse-temurin:21-jdk-alpine

# Step 2: Set the folder inside the container where commands will run
WORKDIR /app

# Step 3: Copy the compiled jar into the container.
# JAR_FILE is relative to the build context, so the same Dockerfile works from
# the repo root (default) or from this directory after staging the jar here:
#   repo root : docker build -f build/Dockerfile -t intuitive-aws-poc .
#   build dir : cp ../app/target/demo-*.jar . \
#               && docker build --build-arg JAR_FILE=demo-*.jar -t intuitive-aws-poc .
ARG JAR_FILE=app/target/demo-*.jar
COPY ${JAR_FILE} app.jar

# Step 4: Tell the container to launch your Spring Boot app when it boots-up
ENTRYPOINT ["java", "-jar", "app.jar"]

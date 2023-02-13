
# FROM python:2.7

# RUN mkdir app
# COPY django/notejam app/

# COPY django/requirements.txt ./
# RUN pip install -r requirements.txt
# RUN pip install psycopg2
# WORKDIR app/

# EXPOSE 5000


FROM openjdk:14-jdk-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy the JAR file of the Spring Boot application to the container
COPY target/your-spring-boot-app.jar /app/your-spring-boot-app.jar

# Set environment variables to configure the application
ENV JAVA_OPTS=""

# Expose port 8080 to make the HTTP endpoint of the application accessible
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "your-spring-boot-app.jar"]


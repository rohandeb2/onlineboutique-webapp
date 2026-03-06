# --- Stage 1: Build Stage ---
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

# Copy wrapper and set permissions
COPY gradlew .
COPY gradle/ gradle/
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew

COPY build.gradle settings.gradle ./
RUN ./gradlew dependencies --no-daemon

COPY . .
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew
RUN ./gradlew installDist --no-daemon

# --- Stage 2: Hardened Runtime ---
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy the contents of the hipstershop install folder to /app
COPY --from=builder /app/build/install/hipstershop /app/

# Senior Tip: Let's verify the script name. 
# In this specific repo, the script is usually 'adservice' (lowercase)
# but the folder was 'hipstershop'. 

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Environment variables for Java

EXPOSE 9555

# This must match the filename inside /app/bin/
ENTRYPOINT ["/app/bin/AdService"]

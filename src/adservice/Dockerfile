FROM eclipse-temurin:21-jdk AS builder
WORKDIR /app

COPY gradlew .
COPY gradle/ gradle/
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew

COPY build.gradle settings.gradle ./
RUN ./gradlew dependencies --no-daemon

COPY . .
RUN sed -i 's/\r$//' gradlew && chmod +x gradlew
RUN ./gradlew installDist --no-daemon

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

COPY --from=builder /app/build/install/hipstershop /app/

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75.0"
ENV DISABLE_PROFILER=1

EXPOSE 9555

ENTRYPOINT ["/app/bin/adservice"]
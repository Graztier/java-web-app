FROM adoptopenjdk/openjdk11:alpine-slim as build
WORKDIR /workspace/app

RUN ./mvnw install -DskipTests
RUN echo 'test value'

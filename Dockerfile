FROM adoptopenjdk/openjdk11:alpine-slim as build
WORKDIR /workspace/app


RUN echo 'test value'

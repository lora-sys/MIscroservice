FROM docker.m.daocloud.io/library/alpine:latest
RUN apk add --no-cache entr
WORKDIR /app

RUN touch /tmp/.restart-proc && chmod 666 /tmp/.restart-proc

ADD shared shared
ADD build build

ENTRYPOINT ["sh", "-c", "echo /tmp/.restart-proc | entr -n -r /app/build/trip-service"]
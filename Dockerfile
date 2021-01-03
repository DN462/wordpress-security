FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add apache2 php7
FROM alpine:latest

RUN apk add --no-cache \
    bash \
    git

COPY src/gitlab-push.sh /usr/local/bin/gitlab-push

RUN chmod +x /usr/local/bin/gitlab-push

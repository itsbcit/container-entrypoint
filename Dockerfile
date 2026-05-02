FROM alpine:latest

ADD container-entrypoint.sh /container-entrypoint.sh
ADD container-entrypoint.d /container-entrypoint.d
RUN chmod 555 /container-entrypoint.sh

ENTRYPOINT [ "/container-entrypoint.sh" ]

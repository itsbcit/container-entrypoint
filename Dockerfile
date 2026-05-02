FROM alpine:latest

ADD container-entrypoint.sh /container-entrypoint.sh
ADD container-entrypoint.d /container-entrypoint.d
RUN chmod 555 /container-entrypoint.sh \
 && chmod 664 /etc/passwd /etc/group

ENTRYPOINT [ "/container-entrypoint.sh" ]

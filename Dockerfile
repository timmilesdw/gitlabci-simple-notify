FROM alpine:3.15

RUN apk add --no-cache curl

COPY --chown=1001 notify.sh .

RUN chmod +x /notify.sh

USER 1001

ENTRYPOINT [ "/notify.sh" ]
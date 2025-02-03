FROM alpine:latest

MAINTAINER Kruky

ENV INST_RCLONE_VERSION=current
ENV ARCH=amd64
ENV SYNC_SRC=
ENV SYNC_DEST=
ENV SYNC_OPTS=-v
ENV RCLONE_OPTS="--config /config/rclone.conf"
ENV CRON=
ENV CRON_ABORT=
ENV FORCE_SYNC=
ENV CHECK_URL=
ENV TZ=

RUN apk -U add ca-certificates fuse wget dcron tzdata \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && wget -q https://beta.rclone.org/branch/fix-7405-onedrive-upload/v1.66.0-beta.7595.5841b1253.fix-7405-onedrive-upload/rclone-v1.66.0-beta.7595.5841b1253.fix-7405-onedrive-upload-linux-amd64.zip \
    && unzip /tmp/rclone-*-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone*

COPY entrypoint.sh /
COPY sync.sh /
COPY sync-abort.sh /

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]

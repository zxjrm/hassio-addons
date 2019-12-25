ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG="C.UTF-8" HOME="/home/vlc"

COPY run.sh / && chmod a+x /run.sh
# Copy data for add-on
RUN apk update && \
  apk add --no-cache vlc && \
  sed -i 's/geteuid/getppid/' /usr/bin/vlc && \
  sed -i '197s#.*#    dir = dir == undefined ? "file:///share" : dir;#' /usr/share/vlc/lua/http/js/controllers.js && \
CMD [ "/run.sh" ]

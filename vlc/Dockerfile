ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG="C.UTF-8" HOME="/share"

COPY run.sh / && chmod a+x /run.sh
# Copy data for add-on
RUN sed -i 's/geteuid/getppid/' /usr/bin/vlc && \
  sed -i '197s#.*#    dir = dir == undefined ? "file:///share" : dir;#' /usr/share/vlc/lua/http/js/controllers.js && \
CMD [ "/run.sh" ]

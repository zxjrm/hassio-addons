ARG BUILD_FROM
FROM $BUILD_FROM

COPY run.sh / && chmod a+x /run.sh
COPY asound.conf /etc/ && chmod a+x /etc/asound.conf
# Copy data for add-on
CMD [ "/run.sh" ]

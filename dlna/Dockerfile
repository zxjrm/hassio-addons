ARG BUILD_FROM
FROM $BUILD_FROM

COPY run.sh / && chmod a+x /run.sh && COPY asound.conf /etc/
# Copy data for add-on
CMD [ "/run.sh" ]

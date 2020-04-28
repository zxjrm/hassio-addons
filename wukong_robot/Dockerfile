ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG="C.UTF-8" HOME="/root"

RUN curl -sL -o "/wukong-robot.tar.gz" \
  "https://github.com/zxjrm/hassio-addons/tree/master/wukong_robot/wukong-robot.tar.gz" && \
  tar xzvf "wukong-robot.tar.gz" && \
  rm /wukong-robot.tar.gz
CMD [ "/run.sh" ]

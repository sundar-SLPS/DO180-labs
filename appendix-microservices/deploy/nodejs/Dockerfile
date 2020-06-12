FROM rhscl/nodejs-8-rhel7:latest
MAINTAINER username <username@example.com>
ARG NEXUS_BASE_URL

EXPOSE	30080

COPY build /opt/app-root/src

RUN source scl_source enable rh-nodejs8 && \
    npm install --registry=http://$NEXUS_BASE_URL/repository/nodejs/

CMD	["/bin/bash","-c","./run.sh"]

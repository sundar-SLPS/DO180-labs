FROM	ubi7/ubi:7.7

MAINTAINER username <username@example.com>

ENV	HOME /var/www/html

# The RUN command below is needed due to constraints
# of this static, disconnected instructional environment.
# This ubi 7.7 container is more up-to-date than the
# lab enviroment's yum repositories.  This run command
# will ensure there are no dependency issues with
# rh-nodejs4 package installed later.
RUN yum downgrade -y krb5-libs libstdc++ libcom_err && \
    yum install -y --setopt=tsflags=nodocs \
    httpd \
    openssl-devel \
    procps-ng \
    which && \
    yum clean all -y && \
    rm -rf /var/cache/yum

EXPOSE  80

CMD	["httpd", "-D", "FOREGROUND"]

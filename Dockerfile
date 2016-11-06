FROM ubuntu:16.04
MAINTAINER rainu <rainu@raysha.de>

ENV IMAPSYNC_LINK https://github.com/imapsync/imapsync/archive/imapsync-1.727.tar.gz

RUN apt-get update &&\
    apt-get -y install build-essential libio-socket-ssl-perl wget &&\

    wget -nv $IMAPSYNC_LINK -O /tmp/imapsync.tar.gz &&\
    tar -xzvf /tmp/imapsync.tar.gz -C /opt/ && mv /opt/$(ls /opt/) /opt/imapsync/ &&\

    cd /opt/imapsync/ &&\
    echo "yes" | cpan &&\
    cpan -i $(./INSTALL.d/prerequisites_imapsync | tail -1 | cut -d\" -f2)&&\
    make install &&\
    cd / &&\

    apt-get remove -y --purge build-essential wget &&\
    apt-get -y autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/*

ENTRYPOINT ["imapsync"]

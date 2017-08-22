############################################################
# Dockerfile to build firefox container images
# Based on https://wiki.ubuntuusers.de/Java/Installation/Oracle_Java/Java_8/
FROM [user.id]/[parent.repository][parent.tag]

###########################################################
# File Author / Maintainer
MAINTAINER [user.name] "[user.email]"
################## BEGIN INSTALLATION ######################
USER root
RUN /bin/bash -c "apt-get update && apt-get upgrade -y && apt-get clean && apt-get autoremove"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y install libwebkitgtk-1.0-0 libxtst6

#download.oracle.com/otn/java/jdk/8u31-b13/jre-8u31-linux-x64.tar.gz
ADD PortfolioPerformance-linux.gtk.x86_64.tar.gz /
RUN ln -s /opt/Oracle_Java/jre1.8.0_$JAVA_VERSION /portfolio/jre
RUN mkdir -p /home/user && \
    echo "user:x:1000:1000:Default User,,,:/home/user:/bin/bash" >> /etc/passwd && \
    echo "user:x:1000:" >> /etc/group && \
    #echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user && \
    #chmod 0440 /etc/sudoers.d/user && \
    chown user:user -R /home/user

VOLUME /data
USER user
ENV HOME /home/user
WORKDIR /home/user
CMD /portfolio/PortfolioPerformance


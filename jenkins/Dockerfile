FROM jenkins

######################################################################
# Jenkins plugins
######################################################################
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt


######################################################################
# Docker and docker-compose
######################################################################
USER root
RUN curl https://get.docker.com/builds/Linux/x86_64/docker-latest > /usr/local/bin/docker && chmod +x /usr/local/bin/docker
RUN curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

# This is a bit of a hack to allow Jenkins to access docker -- the actual GID will likely change from machine to machine
RUN addgroup --gid 999 docker; addgroup jenkins docker


######################################################################
# Build packages
######################################################################

RUN apt-get update
RUN apt-get -y install python-pip make git-core
RUN pip install virtualenv


######################################################################
# Configuration and initial jobs
######################################################################

USER jenkins
ADD ssh /usr/share/jenkins/ref/.ssh
ADD jobs /usr/share/jenkins/ref/jobs
ADD config.xml credentials.xml /usr/share/jenkins/ref/



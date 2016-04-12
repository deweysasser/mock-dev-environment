FROM jenkins
USER root
RUN apt-get update
RUN apt-get -y install python-pip make 
RUN curl https://get.docker.com/builds/Linux/x86_64/docker-latest > /usr/local/bin/docker && chmod +x /usr/local/bin/docker
RUN curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose
RUN addgroup --gid 999 docker; addgroup jenkins docker
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt



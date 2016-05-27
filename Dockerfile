FROM ubuntu:xenial
MAINTAINER ISCPIF <contact@iscpif.fr>

RUN apt-get update && apt-get install -y ca-certificates wget openjdk-8-jdk git && apt clean
RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

COPY sbt /usr/local/bin/
RUN mkdir -p /root/.sbt/0.13/plugins
COPY plugin.sbt /root/.sbt/0.13/plugins/plugins.sbt

RUN cd /tmp/ && git clone https://github.com/openmole/openmole.git && \
    cd openmole/build-system && sbt publish-local && \
    cd ../libraries && sbt publish-local && \
    cd ../openmole && sbt "project openmole" && sbt assemble && \
    mv bin/openmole/target/assemble /usr/local/lib/openmole && \
    rm -rf /tmp/openmole/ /root/.ivy2 

RUN chmod +x /usr/local/lib/openmole/openmole
RUN cd /usr/local/bin/ && ln -s ../lib/openmole/openmole

RUN adduser openmole --gecos "" --disabled-password --home /var/openmole/

USER openmole
ENTRYPOINT ["openmole", "--port", "8888", "--remote"]


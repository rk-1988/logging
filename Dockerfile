#!/bin/bash

FROM ubuntu:latest

WORKDIR /
RUN apt-get update \
&& apt-get install -y curl \
&& apt-get install -y tar
#RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=v8&source=github" \
COPY cf8-cli_8.2.0_linux_x86-64.tgz /cf8-cli_8.2.0_linux_x86-64.tgz
RUN ls -ltrh / \
&& tar -xvzf /cf8-cli_8.2.0_linux_x86-64.tgz \
&& mv /cf8 /usr/local/bin \
&& mv /cf /usr/local/bin \
&& ls -ltrh /usr/local/bin \
&& curl -o /usr/share/bash-completion/completions/cf8 https://raw.githubusercontent.com/cloudfoundry/cli-ci/master/ci/installers/completion/cf8 \
&& cf version
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


#FROM ubuntu:latest
#RUN sudo apt-get update
#RUN sudo apt-get install -y ca-certificates jq
#RUN echo "deb https://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
#RUN sudo apt-get update
#RUN sudo apt-get install -y cf8-cli
#ADD entrypoint.sh /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

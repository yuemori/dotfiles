FROM buildpack-deps:xenial-curl

RUN set -ex \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
      sudo \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd ubuntu \
    && useradd -g ubuntu -s /bin/bash -m ubuntu \
    && echo 'ubuntu ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-linux -O /usr/local/bin/mitamae \
    && chmod +x /usr/local/bin/mitamae

USER ubuntu

WORKDIR /home/ubuntu
COPY provisioning /provisioning

# RUN echo "{ \"home\":\"/home/ubuntu\",\"current_user\":\"ubuntu\" }" > /tmp/node.json
RUN echo "{ \"home\":\"/home/ubuntu\",\"current_user\":\"ubuntu\" }" > /tmp/node.json \
    && sudo mitamae local --node-json /tmp/node.json /provisioning/roles/dotfile.rb

CMD ["/bin/bash"]

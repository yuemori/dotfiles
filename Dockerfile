FROM buildpack-deps:xenial-curl

RUN set -ex \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
      sudo \
      curl \
    && rm -rf /var/lib/apt/lists/*

ARG user=wakaba260

RUN groupadd $user \
    && useradd -g $user -s /bin/bash -m $user \
    && echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

WORKDIR /home/$user

RUN wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-linux -O /usr/bin/mitamae \
    && chmod +x /usr/bin/mitamae

USER $user
ENV USER=$user

COPY provisioning /tmp/provisioning
RUN echo "{ \"home\":\"/home/$user\",\"current_user\":\"$user\" }" > /tmp/node.json \
    && mitamae local /tmp/provisioning/roles/dotfile.rb -j /tmp/node.json

CMD ["/bin/zsh"]

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

USER $user
ENV USER=$user

COPY provisioning /tmp/provisioning
COPY run.sh run.sh
RUN ./run.sh

CMD ["/bin/zsh"]

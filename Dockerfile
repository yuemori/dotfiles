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

RUN wget https://github.com/itamae-kitchen/mitamae/releases/download/v1.4.5/mitamae-x86_64-linux -O /usr/local/bin/mitamae \
    && chmod +x /usr/local/bin/mitamae

WORKDIR /home/$user

USER $user
ENV USER=$user

RUN curl https://raw.githubusercontent.com/yuemori/dotfiles/master/run.sh | bash -l

CMD ["/bin/zsh"]

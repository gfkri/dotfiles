# Base image — swap for pytorch/pytorch:latest for ML work
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=appuser
ARG USER_UID=1001
ARG USER_GID=1001

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git curl sudo gosu \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${USER_GID} ${USERNAME} \
    && useradd -u ${USER_UID} -g ${USERNAME} -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER ${USERNAME}
ARG CACHEBUST=1
RUN git clone https://github.com/gfkri/dotfiles.git /home/${USERNAME}/.dotfiles \
    && /home/${USERNAME}/.dotfiles/install.sh --force-stow \
    && sudo usermod -s /bin/zsh ${USERNAME} \
    && /home/${USERNAME}/.tmux/plugins/tpm/bin/install_plugins

ENV SHELL=/bin/zsh
ENV USERNAME=${USERNAME}
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV COLORTERM=truecolor

WORKDIR /home/${USERNAME}

USER root
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/zsh"]

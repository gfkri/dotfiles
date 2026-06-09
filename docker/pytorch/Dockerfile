ARG PYTORCH_TAG=cuda-13.0.2-auto
FROM --platform=linux/amd64 vastai/pytorch:${PYTORCH_TAG}

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
    && sudo usermod -s /bin/zsh ${USERNAME}

ENV SHELL=/bin/zsh
ENV USERNAME=${USERNAME}

WORKDIR /home/${USERNAME}

USER root
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/zsh"]

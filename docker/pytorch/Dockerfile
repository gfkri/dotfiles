ARG PYTORCH_TAG=cuda-13.0.2-auto
ARG BUILD_PLATFORM=linux/amd64
FROM --platform=${BUILD_PLATFORM} vastai/pytorch:${PYTORCH_TAG}

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=appuser
ARG USER_UID=1001
ARG USER_GID=1001

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git curl sudo gosu \
    && rm -rf /var/lib/apt/lists/*

RUN existing_user=$(getent passwd ${USER_UID} | cut -d: -f1) \
    && [ -n "$existing_user" ] && userdel -r "$existing_user" || true \
    && existing_group=$(getent group ${USER_GID} | cut -d: -f1) \
    && [ -n "$existing_group" ] && groupdel "$existing_group" || true \
    && groupadd -g ${USER_GID} ${USERNAME} \
    && useradd -u ${USER_UID} -g ${USERNAME} -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER ${USERNAME}
ARG CACHEBUST=1
RUN bash <(curl -fsSL https://raw.githubusercontent.com/gfkri/dotfiles/main/provision.sh)

ENV SHELL=/bin/zsh
ENV USERNAME=${USERNAME}
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV COLORTERM=truecolor

WORKDIR /home/${USERNAME}

USER root
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/zsh"]

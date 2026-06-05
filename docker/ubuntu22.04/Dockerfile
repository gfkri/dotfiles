# Base image — swap for pytorch/pytorch:latest for ML work
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Prerequisites: git + curl needed before install.sh runs
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates git curl \
    && rm -rf /var/lib/apt/lists/*

# Clone dotfiles and run full setup
RUN git clone https://github.com/gfkri/dotfiles.git /root/.dotfiles \
    && /root/.dotfiles/install.sh

# Set zsh as default shell
SHELL ["/bin/zsh", "-c"]
ENV SHELL=/bin/zsh

CMD ["/bin/zsh"]

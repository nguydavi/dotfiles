FROM ubuntu:latest

ARG USER=testuser

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl git sudo vim zsh && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user with passwordless sudo privileges
RUN useradd -s /bin/bash -m $USER && \
    usermod -aG sudo $USER && \
    printf "%s\n" \
        "$USER ALL=(ALL) NOPASSWD:ALL" \
        "Defaults:$USER !authenticate" \
        > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR /home/$USER/dotfiles

CMD ["/bin/bash"]

# FROM ubuntu:latest as builder
#
# # ctags builder
#
# WORKDIR /mnt/build/ctags
#
# RUN apt-get install -y \
# 	git \
# 	xfce4-dev-tools \
# 	build-base
#
# RUN \
# 	git clone https://github.com/universal-ctags/ctags \
# 	&& cd ctags \
# 	&& ./autogen.sh \
# 	&& ./configure --prefix=/usr/local \
# 	&& make \
# 	&& make install
#


FROM ubuntu:latest

LABEL \
  maintainer="daephx <36192863+daephx@users.noreply.github.com>" \
  description="Containerized development environement" \
  version="0.0.1"

ENV \
  UID="1000" \
  GID="1000" \
  UNAME="neovim" \
  GNAME="neovim" \
  SHELL="/bin/bash" \
	PATH="/home/${UNAME}/.local/bin:${PATH}" \
  DEBIAN_FRONTEND="noninteractive" \
	NVIM_CONFIG="/home/${UNAME}/.config/nvim" \
  WORKSPACE="/mnt/workspace"


# COPY --from=builder /usr/local/bin/ctags /usr/local/bin


# Commands to update the image
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y software-properties-common

# Add repositories
RUN add-apt-repository ppa:neovim-ppa/unstable

# Install packages
RUN apt-get update && \
    apt-get install -y \
    git \
    sudo \
    curl \
    python3-dev \
    python3-pip \
    neovim \
    ripgrep \
    xclip \
    zsh

# RUN apt-get update && \
#     apt-get install -y \
#     git \
#     curl \
#     sudo \
#     neovim \
#     python-dev \
#     python-pip \
#     python3-dev \
#     python3-pip \
#     autoconf \
#     automake \
#     cmake \
#     fzf \
#     g++ \
#     clang \
#     gettext \
#     libtool \
#     libtool-bin \
#     ninja-build \
#     nodejs \
#     npm \
#     pkg-config \
#     ripgrep \
#     tree \
#     tzdata \
#     unzip \
#     xclip \
#     zsh

# TODO: Verify this
# Official Debian and Ubuntu images automatically run apt-get clean, so explicit invocation is not required.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN groupadd -g ${GID} ${GNAME}
RUN useradd -m -g ${GNAME} -s /bin/bash -N -u ${UID} ${UNAME}
RUN echo "${UNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${UNAME}
RUN chmod 0440 /etc/sudoers.d/${UNAME}
# RUN chsh -s /usr/bin/zsh ${UNAME}
RUN if [ ! -d /home/${UNAME}/ ]; then mkdir /home/${UNAME}/; fi
RUN chown ${UNAME}:${GNAME} /home/${UNAME}

WORKDIR /home/${UNAME}/

# TODO: Consider mounting instead of copy?
COPY . /home/${UNAME}/.config/nvim
RUN chown -R ${UNAME}:${GNAME} /home/${UNAME}/.config

USER ${UNAME}


RUN pip install neovim
RUN pip3 install neovim

RUN nvim --headless -c "autocmd User PackerComplete quitall"
# 	nvim --headless -c "TSInstallSync" -c "q"

# TODO: Add volume mounts for projects
# WORKDIR ${WORKSPACE}

ENTRYPOINT ["bash"]

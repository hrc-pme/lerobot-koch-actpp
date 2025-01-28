################################################################################################
# - Base stage
#   - This stage serves as the foundational stage for all other stages.
#   - Base image: Nvidia CUDE 12.4.0 runtime image on Ubuntu 22.04
#       - https://hub.docker.com/layers/nvidia/cuda/12.4.0-runtime-ubuntu22.04/images/sha256-2d205a50fefc321aca51a1d3aa46fb9a633dd2509a10e28c8bd34a6cb2027619
################################################################################################

FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04 AS base

LABEL org.opencontainers.image.title="Docker Image of HRC ACT-Plus-Plus for Koch"
LABEL org.opencontainers.image.authors="yoseph.huang@gmail.com"
LABEL org.opencontainers.image.licenses="MIT"

ARG USERNAME=hrc
ARG USER_UID=1000
ARG USER_GID=$USER_UID

SHELL ["/bin/bash", "-c"]


################################################################################################
# - Python Building stage
#   - In this stage, I will install and set python3.8.10 as the default python version.
#   - Building tools will be removed after this stage.
################################################################################################

FROM base AS python-build

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    cmake \ 
    curl \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    wget \
    xz-utils \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Download and compile Python 3.10.0
RUN wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz && \
    tar -xvf Python-3.10.0.tgz && \
    cd Python-3.10.0 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    cd .. && rm -rf Python-3.10.0 Python-3.10.0.tgz


################################################################################################
# - Python Dependencies Installation stage
#   - In this stage, I will install all the python dependencies.
#       - lerobot github repository: https://github.com/hrc-pme/lerobot/blob/963738d983480b1cd19295b2cb0630d0cf5c5bb5/examples/7_get_started_with_real_robot.md
################################################################################################

FROM base AS python-dep

COPY --from=python-build /usr/local/lib/python3.10 /usr/local/lib/python3.10
COPY --from=python-build /usr/local/bin/python3.10 /usr/local/bin/python3.10
COPY --from=python-build /usr/local/bin/pip3.10 /usr/local/bin/pip3


# Set Python 3.10.0 as default
RUN ln -sf /usr/local/bin/python3.10 /usr/bin/python3 && \
    ln -sf /usr/local/bin/pip3.10 /usr/bin/pip

# Install build tools 
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    git \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Install project dependencies
WORKDIR /root
RUN git clone https://github.com/huggingface/lerobot && \
    cd lerobot && git checkout 4def6d6ac2f89863348cd8467c4202d3eb6b8bc0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/lerobot
RUN pip3 install --upgrade pip && \
    pip3 install \
    ffmpeg \
    opencv-python-headless==4.10.0.84 && \
    CPPFLAGS="-I/usr/include/python3.10" pip3 install evdev && \
    pip3 install -e .["dynamixel"] 

WORKDIR /root
RUN rm -rf lerobot


################################################################################################
# - Dev Tools Installation stage
#   - In this stage, I will install some developing tools.
################################################################################################

FROM python-dep AS dev

# Install libraries 
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libegl1-mesa \
    speech-dispatcher \
    && rm -rf /var/lib/apt/lists/*
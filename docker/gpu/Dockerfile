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




WORKDIR /home

FROM ubuntu:20.10
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
  apt-get install --yes --no-install-recommends \
        alien && \
  rm -rf /var/lib/apt/lists/*

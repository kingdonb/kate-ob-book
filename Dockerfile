# LTS Image
FROM ubuntu:18.04

LABEL maintainer="kingdon@nerdland.info"

ARG DEBIAN_FRONTEND="noninteractive"

WORKDIR /src

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    calibre \
    pandoc \
    ruby \
    ruby-dev \
    wget \
    zlib1g-dev \
    file \
    ruby-bundler \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile /src/Gemfile
COPY Gemfile.lock /src/Gemfile.lock
RUN bundle install
COPY . /src/

RUN bundle

ENTRYPOINT ["/src/bootstrap.sh", "docker"]

VOLUME ["/output"]

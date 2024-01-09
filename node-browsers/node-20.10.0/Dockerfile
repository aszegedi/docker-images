FROM node:20.10.0-buster

ARG TARGETARCH
ARG TARGETOS
ARG TARGETVARIANT
ARG TARGETPLATFORM

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qqy && \
    apt-get install --no-install-recommends -qqy \
    libgtk2.0-0 \
    libgtk-3-0 \
    libnotify-dev \
    libgconf-2-4 \
    libgbm-dev \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb \
    vim-tiny \
    nano \
    fonts-arphic-bsmi00lp \
    fonts-arphic-gbsn00lp \
    fonts-arphic-gkai00mp \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    ttf-wqy-zenhei \
    ttf-wqy-microhei \
    xfonts-wqy \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install Chrome and its dependencies
RUN apt-get update -qqy && \
    apt-get install -qqy \
    fonts-liberation \
    git \
    libcurl4 \
    libcurl3-gnutls \
    libcurl3-nss \
    xdg-utils \
    wget \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN apt-get update -qqy && \
    apt-get -qqy install \
	chromium \
    yarn \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

ENV CHROME_BIN=/usr/bin/chromium \
    CHROME_PATH=/usr/lib/chromium/
RUN ln -fs /usr/bin/chromium /usr/bin/chrome

# a few environment variables to make NPM installs easier
# good colors for most applications
ENV TERM xterm
# avoid million NPM install messages
ENV npm_config_loglevel warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm true

# versions of local tools
RUN npm --version \
  && yarn --version \
  && node -p process.versions \
  && node -p 'module.paths' \
  && echo  " node version:    $(node -v) \n" \
    "npm version:     $(npm -v) \n" \
    "yarn version:    $(yarn -v) \n" \
    "debian version:  $(cat /etc/debian_version) \n" \
    "user:            $(whoami) \n" \
    "architecture:    $TARGETARCH \n" \
    "os component:    $TARGETOS \n" \
    "architecture:    $TARGETVARIANT \n" \
    "platform:        $TARGETPLATFORM \n"
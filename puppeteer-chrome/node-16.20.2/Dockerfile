FROM node:16.20.2-slim

ARG TARGETARCH

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
    procps \
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

# Install dependencies
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

# Docker In Docker install
RUN apt-get update -qqy && \
    apt-get -qqy install \
    apt-transport-https \
    lxc \
    iptables \
    curl \
    vim \
    dpkg \
    lsb-release ca-certificates && \
    curl -sSL https://download.docker.com/linux/debian/gpg | gpg --dearmor > /usr/share/keyrings/docker-ce.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-ce.gpg] https://download.docker.com/linux/debian $(lsb_release -sc) stable" > /etc/apt/sources.list.d/docker.list

RUN apt-get update -qqy && \
    apt-get -qqy install \
    docker-ce \
    docker-ce-cli \
    containerd.io

# Install Chrome dependencies
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
ENV TERM=xterm
# avoid million NPM install messages
ENV npm_config_loglevel=warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm=true

# Install puppeteer so it's available in the container.
COPY /package.json /package.json
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
RUN yarn add puppeteer

RUN npm --version \
  && yarn --version \
  && node -p process.versions \
  && node -p 'module.paths' \
  && echo  " node version:    $(node -v) \n" \
    "npm version:     $(npm -v) \n" \
    "yarn version:    $(yarn -v) \n" \
    "debian version:  $(cat /etc/debian_version) \n" \
    "user:            $(whoami) \n" \
    "chrome version:  $(google-chrome --version) \n" \
    "firefox version: $(firefox --version) \n" \
    "edge version:    $(edge --version) \n" \
    "architecture:    $TARGETARCH \n" \
    "os component:    $TARGETOS \n" \
    "architecture:    $TARGETVARIANT \n" \
    "platform:        $TARGETPLATFORM \n"

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

CMD ["chrome", "--headless", "--disable-dev-shm-usage", "--disable-gpu", "--no-sandbox", "--disable-setuid-sandbox", "--use-gl=egl", "--disable-web-security", "--disable-extensions", "--disable-default-apps", "--disable-translate", "--hide-scrollbars", "--mute-audio", "--ignore-certificate-errors", "--allow-insecure-localhost"]
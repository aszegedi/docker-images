FROM node:14.17.6-alpine3.14

ARG TARGETARCH

# Set up glibc
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc
ENV GLIBC_VERSION=2.34-r0
RUN set -ex && \
    apk --update add libstdc++ curl ca-certificates && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION}; \
        do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

# Install Chrome dependencies
RUN apk add --no-cache --update \
	  alsa-lib \
	  atk \
	  at-spi2-atk \
	  expat \
	  glib \
	  gtk+3.0 \
	  libdrm \
	  libx11 \
	  libxcomposite \
	  libxcursor \
	  libxdamage \
	  libxext \
	  libxi \
	  libxrandr \
	  libxscrnsaver \
	  libxshmfence \
	  libxtst \
	  mesa-gbm \
	  pango \
      chromium --repository=http://dl-cdn.alpinelinux.org/alpine/v3.14/main

RUN apk add --no-cache --update \
      nss \
      freetype \
      harfbuzz \
      ca-certificates \
      ttf-freefont \
      nodejs \
      yarn \
      bash \
      findutils \
      wget \
      dpkg \
      xeyes \
  && rm -rf /var/cache/apk/* /tmp/*

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Install puppeteer so it's available in the container.
RUN npm i puppeteer
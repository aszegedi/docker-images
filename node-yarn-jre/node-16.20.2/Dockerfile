FROM node:16.20.2

ARG TARGETARCH

RUN apt-get update -qqy && \
    apt-get install -qqy \
    default-jre \
    yarn \
    # clean up
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_$TARGETARCH.deb && \
    dpkg -i dumb-init_*.deb

ENTRYPOINT ["dumb-init", "--"]
CMD ["echo", "run this container with command like 'yarn install'"]
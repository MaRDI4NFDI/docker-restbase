FROM docker-registry.wikimedia.org/buster-nodejs10-devel:0.0.1-s1-20230618

RUN apt-get update && apt-get install -y --no-install-recommends \
  && apt-get install -y git build-essential python-pkgconfig \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /srv
COPY restbase /srv

# hack to avoid problem fetching from github from within docker
RUN mkdir node_modules
COPY content-type /srv/node_modules/content-type

RUN npm install
COPY config.yaml /srv/config.yaml

EXPOSE 7231
CMD npm start
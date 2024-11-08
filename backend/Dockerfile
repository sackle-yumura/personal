# jemalloc
FROM ruby:3.1.6-alpine AS builder

RUN apk add build-base

RUN wget -O - https://github.com/jemalloc/jemalloc/releases/download/5.2.1/jemalloc-5.2.1.tar.bz2 | tar -xj && \
    cd jemalloc-5.2.1 && \
    ./configure && \
    make && \
    make install

# bundle
FROM ruby:3.1.6-alpine AS bundler

RUN apk --update --no-cache add shadow sudo busybox-suid mariadb-connector-c-dev tzdata alpine-sdk

WORKDIR /rails

COPY Gemfile Gemfile.lock ./

RUN bundle install && \
    find vendor/bundle/ruby -path '*/gems/*/ext/*/Makefile' -exec dirname {} \; | xargs -n1 -P$(nproc) -I{} make -C {} clean

# Rails
FROM ruby:3.1.6-alpine
ENV LANG C.UTF-8

COPY --from=bundler /usr/local/bundle /usr/local/bundle

COPY --from=builder /usr/local/lib/libjemalloc.so.2 /usr/local/lib/
ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2

ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD . $APP_ROOT

RUN apk update \
    && apk add --update --no-cache \
      bash \
      mariadb-connector-c-dev \
      nodejs \
      tzdata \
      less \
      xz-libs \
    && apk add --update --no-cache --virtual .build-dependencies \
      build-base \
      curl-dev \
      gcc \
      g++ \
      libxml2-dev \
      libxslt-dev \
      linux-headers \
      make \
      mariadb-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev \
    && bundle install -j4 \
    && apk del .build-dependencies \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

ARG ASSETS_PRECOMPILE=true
RUN if [ ${ASSETS_PRECOMPILE} = true ]; then \
  SECRET_KEY_BASE=1 RAILS_ENV=production rake assets:precompile \
;fi

VOLUME [ "/app/public", "/app/tmp" ]

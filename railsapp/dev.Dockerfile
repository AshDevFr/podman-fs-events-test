FROM ruby:3.2-alpine

RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache  \
    build-base \
    gcompat \
    git \
    sqlite \
    tzdata

WORKDIR /app

# Install Rails
RUN gem install rails

# Install application gems
COPY Gemfile Gemfile.lock /app/
RUN bundle install

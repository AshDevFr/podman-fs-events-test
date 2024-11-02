FROM node:20-alpine

RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache build-base

WORKDIR /app

COPY package.json package-lock.json /app/

RUN npm install

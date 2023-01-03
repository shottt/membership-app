FROM node:18.4

ENV NODE_PATH /frontend/node_modules

RUN mkdir /frontend
WORKDIR /frontend
RUN npm install create-next-app

COPY . /frontend/
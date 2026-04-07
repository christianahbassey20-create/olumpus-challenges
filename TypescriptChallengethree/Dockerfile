FROM public.ecr.aws/x8v8d7g8/mars-base:latest

WORKDIR /app

COPY package.json ./

RUN NODE_ENV=development npm install --legacy-peer-deps --no-optional || \
    NODE_ENV=development npm install --legacy-peer-deps --ignore-scripts

COPY . .

RUN NODE_ENV=development npm install --save-dev jest-junit --legacy-peer-deps

ENV NODE_ENV=test
ENV NODE_OPTIONS=--unhandled-rejections=strict

CMD ["/bin/bash"]

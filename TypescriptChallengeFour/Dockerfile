FROM public.ecr.aws/x8v8d7g8/mars-base:latest

WORKDIR /app

COPY package.json yarn.lock ./

RUN NODE_ENV=development npm install --legacy-peer-deps --no-optional || \
    NODE_ENV=development npm install --legacy-peer-deps --ignore-scripts
RUN NODE_ENV=development npm install --save-dev jest-junit --legacy-peer-deps

COPY . .

CMD ["/bin/bash"]

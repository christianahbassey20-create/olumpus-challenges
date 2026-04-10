FROM public.ecr.aws/x8v8d7g8/mars-base:latest

WORKDIR /app

COPY package.json yarn.lock ./

RUN npm install -g yarn && yarn install --frozen-lockfile || yarn install

COPY . .

CMD ["/bin/bash"]

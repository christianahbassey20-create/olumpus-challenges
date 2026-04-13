FROM public.ecr.aws/x8v8d7g8/mars-base:latest

WORKDIR /app

COPY . .

RUN node -e "\
  var p=require('./package.json');\
  if(!p.devDependencies['jest-junit']){\
    p.devDependencies['jest-junit']='^16.0.0';\
    require('fs').writeFileSync('package.json',JSON.stringify(p,null,2)+'\n');\
  }" && yarn install --production=false

CMD ["/bin/bash"]

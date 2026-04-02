FROM public.ecr.aws/x8v8d7g8/mars-base:latest
WORKDIR /app
COPY . .
RUN pip install -e . && pip install pytest pytest-django pytest-asyncio pydantic-settings ninja-schema
CMD ["/bin/bash"]

FROM python:3.11

# Install with dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN apt-get update && apt-get install -y wget \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENV PYTHONBURRERED=1
RUN mkdir /backend
WORKDIR /backend

# Install with pip
COPY requirements.txt /backend/
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY . /backend/
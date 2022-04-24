From python:3.7-alpine
MAINTAINER Skyfire Ind. App Developers

ENV PYTHONUNBUFFERED 1

# Install dependencies

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client jpeg-dev

# added (jpeg-dev) as a permanent install for pillow

RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

# added (musl-dev zlib zlib-dev) to add dependencies for pillow

RUN pip install python-decouple
RUN pip install -r /requirements.txt

RUN apk del .tmp-build-deps

# Setup directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app /app

# create directories for media for pillow, -p includes all subdirectories

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static

RUN adduser -D user

# ownership to user added, before switching to user, running as root

RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user

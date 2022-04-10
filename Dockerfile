From python:3-7-alpine
MAINTAINER Skyfire Ind. App Developers

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install - r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D SA_user
USER SA_user

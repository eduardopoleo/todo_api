FROM ruby:onbuild
MAINTAINER Eduardo Poleo <eduardopoleo@gmail.com>

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev

ENV APP_PATH /usr/src/todo_app
RUN mkdir $APP_PATH
ADD . $APP_PATH
WORKDIR $APP_PATH

RUN bundle install
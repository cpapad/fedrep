FROM ruby:2.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /reputation_service
WORKDIR /reputation_service
ADD Gemfile /reputation_service/Gemfile
ADD Gemfile.lock /reputation_service/Gemfile.lock
RUN bundle install
ADD . /reputation_service


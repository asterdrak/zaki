FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /zaki
WORKDIR /zaki
ADD Gemfile /zaki/Gemfile
ADD Gemfile.lock /zaki/Gemfile.lock
RUN bundle install
ADD . /zaki

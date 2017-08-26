FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /formsub
WORKDIR /formsub
ADD Gemfile /formsub/Gemfile
ADD Gemfile.lock /formsub/Gemfile.lock
RUN bundle install
ADD . /formsub

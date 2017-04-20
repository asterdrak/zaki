FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /rails_template
WORKDIR /rails_template
ADD Gemfile /rails_template/Gemfile
ADD Gemfile.lock /rails_template/Gemfile.lock
RUN bundle install
ADD . /rails_template

FROM ruby:2.3

RUN mkdir -p /app

EXPOSE 3001

COPY Gemfile Gemfile.lock /app/

WORKDIR /app

RUN bundle install

COPY . /app

ENTRYPOINT rails server -p 3001

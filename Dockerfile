FROM ruby:2.3

RUN mkdir -p /app

COPY ./ /app

WORKDIR /app

EXPOSE 3001

RUN bundle install

ENTRYPOINT rails server -p 3001

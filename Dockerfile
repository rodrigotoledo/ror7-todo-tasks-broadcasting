FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y curl libsqlite3-0 libvips

WORKDIR /app

COPY Gemfile ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

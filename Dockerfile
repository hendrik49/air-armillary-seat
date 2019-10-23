FROM ruby:2.6.3
COPY . /app
VOLUME /app
EXPOSE 4567

WORKDIR /app

RUN gem install bundler
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock

RUN bundle install -j 20

CMD ["ruby", "app.rb"]

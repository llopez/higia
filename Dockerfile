FROM ruby:2.4.1-jessie
RUN apt-get update && apt-get install -y nodejs
RUN gem install bundler
RUN mkdir -p /usr/src/app
VOLUME /usr/src/app
COPY Gemfile /usr/src/app
WORKDIR /usr/src/app
ENV RAILS_ENV development
RUN bundle install
RUN rails db:drop db:create db:migrate db:seed
ENTRYPOINT /bin/bash -c "if [ -f tmp/pids/server.pid ]; then rm tmp/pids/server.pid; fi" && rails server -b 0.0.0.0
EXPOSE 3000
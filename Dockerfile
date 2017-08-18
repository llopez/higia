FROM ruby:2.4.1-jessie
RUN apt-get update && apt-get install -y nodejs
RUN gem install bundler
RUN mkdir -p /usr/src/app/
VOLUME /usr/src/app
COPY Gemfile Gemfile.lock /usr/src/app/
WORKDIR /usr/src/app/
ENV RAILS_ENV development
RUN bundle install
#RUN rails db:drop db:create db:migrate db:seed
CMD rails server -b 0.0.0.0
EXPOSE 3000
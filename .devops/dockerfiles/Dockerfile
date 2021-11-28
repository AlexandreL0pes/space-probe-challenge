FROM ruby:3.0.0-slim

ARG RAILS_ENV
ARG APP_VERSION

ENV RAILS_ENV ${RAILS_ENV}
ENV APP_VERSION ${APP_VERSION}

RUN apt-get update -qq && apt-get install -y libpq-dev libcurl4-openssl-dev build-essential git

WORKDIR /space-probe-challenge

COPY Gemfile* /space-probe-challenge/

RUN gem install bundler

RUN bundle install

COPY .devops/dockerfiles/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY . /space-probe-challenge/

RUN echo 'alias rspec="RAILS_ENV=test bundle exec rspec"' >> ~/.bashrc && \
    echo 'alias rubocop="bundle exec rubocop"' >> ~/.bashrc && \
    echo 'alias rails="bundle exec rails"' >> ~/.bashrc

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "bundle", "exec", "puma" ]
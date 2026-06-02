ARG RUBY_VERSION=3.4.1
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 \
        libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"



FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git \
        libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle\ "${BUNDLE_PATH}"/ruby/*/cache \
        "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

RUN SECRET_KEY_BASE_DUMMY=1 DATABASE_URL=postgres://dummy:dummy@localhost/dummy ./bin/rails assets:precompile





FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails


RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails


EXPOSE 3000


CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
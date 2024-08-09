# syntax = docker/dockerfile:1

# Base image with the specified Ruby version
ARG RUBY_VERSION=3.3.0
FROM ruby:$RUBY_VERSION-slim as base

# Set the working directory
WORKDIR /app

# Install build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install application dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy the rest of the application code
COPY . .

# Precompile assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Final stage for the app image
FROM ruby:$RUBY_VERSION-slim as final

# Set the working directory
WORKDIR /app

# Install packages needed for deployment
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips && \
    rm -rf /var/lib/apt/lists/*

# Copy built artifacts: gems, application
COPY --from=base /usr/local/bundle /usr/local/bundle
COPY --from=base /app /app

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database.
COPY bin/docker-entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["rails", "server", "-b", "0.0.0.0"]

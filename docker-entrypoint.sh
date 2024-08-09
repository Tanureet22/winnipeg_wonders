#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Precompile assets if they are not already compiled
if [ -z "$(ls -A /app/public/assets)" ]; then
  bundle exec rails assets:precompile
fi

# Prepare the database
bundle exec rails db:create db:migrate

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

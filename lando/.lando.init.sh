#!/bin/bash

# Shallow clone and checkout the 10.1.x branch
# NOTE: you currently need to use the = below in `--remote-options` for yargs to parse this correctly
lando init \
  --source remote \
  --remote-url https://github.com/drupal/drupal.git \
  --remote-options="--branch 10.1.x --depth 1" \
  --recipe drupal10 \
  --webroot web \
  --name my-d10

# Create latest drupal10 project via composer
# lando composer create-project drupal/recommended-project:10.1.x

# sudo systemctl stop docker && sudo systemctl stop docker.socket && sudo service docker start

# Start it up
# lando start

# Install a site local drush and composer-patches
# lando composer require drush/drush cweagans/composer-patches:^1.7

# Install drupal
lando drush --root="/app/web" \
  site-install standard \
  --locale=fr \
  --db-url=mysql://drupal10:drupal10@database:3306/drupal10 \
  --site-name="Drupal 10" \
  --account-name=admin \
  --account-pass=admin --yes

# List information about this app
# lando info

#!/bin/bash

# Install drush and composer-patches
lando composer require cweagans/composer-patches:^1.7

# lando -v db-import backup.sql.gz

lando drush --root="/app/web" \
  site-install standard \
  --locale=fr \
  --db-url=mysql://drupal10:drupal10@database:3306/drupal10 \
  --site-name="Drupal 10" \
  --account-name=admin \
  --account-pass=admin --yes

# Install some essential modules and enable them

# Require and download modules via composer
lando composer require \
  "drupal/module_filter" \
  "drupal/admin_toolbar" \
  "drupal/devel" \
  "drupal/devel_kint_extras" \
  "drupal/ctools:^4.0" \
  "drupal/config_split" \
  "drupal/structure_sync:^2.0" \
  "drupal/transliterate_filenames"
  # "drupal/toolbar_anti_flicker"

lando composer update --with-all-dependencies --no-interaction 

# Enable modules via drush
lando drush en -y \
  module_filter config_split \
  admin_toolbar admin_toolbar_tools admin_toolbar_search \
  devel devel_generate \
  devel_kint_extras \
  ctools \
  transliterate_filenames
  # toolbar_anti_flicker

# Clear cache
lando drush cr

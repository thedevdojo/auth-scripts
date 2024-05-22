#!/bin/bash

if [ ! -d "apps" ]; then
    mkdir apps
fi

## CD into the apps directory
cd apps

# Remove the existing laravel project directory
rm -rf laravel

# Create a new Laravel project
laravel new laravel --no-interaction

# Change to the project directory
cd laravel

# Require the DevDojo Auth package
composer require devdojo/auth

# Publish the package assets, config, CI, and migrations
php artisan vendor:publish --tag=auth:assets
php artisan vendor:publish --tag=auth:config
php artisan vendor:publish --tag=auth:ci
php artisan vendor:publish --tag=auth:migrations

# Run the migrations
php artisan migrate

# Startup the server on localhost
php artisan serve

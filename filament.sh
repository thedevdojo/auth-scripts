#!/bin/bash

# Create a new Laravel application
./scripts/install-new-laravel-app.sh filament

cd apps/filament

# Install filament
composer require filament/filament:"^3.2" -W --no-interaction
php artisan filament:install --panels --no-interaction

cd ../../

# Call the external script to setup DevDojo Auth
./scripts/setup-devdojo-auth.sh filament

cd apps/filament

# Startup the server on localhost
php artisan serve

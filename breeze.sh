#!/bin/bash

# Create a new Laravel application
./scripts/install-new-laravel-app.sh breeze

cd apps/breeze

# Install Breeze
composer require laravel/breeze --dev --no-interaction
php artisan breeze:install blade --no-interaction
npm install --silent --no-interaction && npm run dev --silent --no-interaction &
php artisan migrate

sed -i '' '/Route::middleware('\'guest\'')\->group(function () {/,/});/d' routes/auth.php

cd ../../

# Call the external script to setup DevDojo Auth
./scripts/setup-devdojo-auth.sh breeze

cd apps/breeze

# Startup the server on localhost
php artisan serve

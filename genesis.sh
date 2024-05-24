#!/bin/bash

# Create a new Laravel application
./scripts/install-new-laravel-app.sh genesis

cd apps/genesis

# Install genesis
composer require devdojo/genesis dev-main --no-interaction
php artisan ui genesis --no-interaction
npm install --silent --no-interaction && npm run dev --silent --no-interaction &

cd ../../

# Call the external script to setup DevDojo Auth
./scripts/setup-devdojo-auth.sh genesis

cd apps/genesis

# Startup the server on localhost
php artisan serve

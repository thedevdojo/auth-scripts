#!/bin/bash

# Create a new Laravel application
./scripts/install-new-laravel-app.sh

# Call the external script to setup DevDojo Auth
./scripts/setup-devdojo-auth.sh

cd apps/laravel

# Startup the server on localhost
php artisan serve

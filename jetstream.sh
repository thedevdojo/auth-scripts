#!/bin/bash

# Create a new Laravel application
./scripts/install-new-laravel-app.sh jetstream

cd apps/jetstream

# Install Jetstream
composer require laravel/jetstream --no-interaction
php artisan jetstream:install livewire --no-interaction
npm install --silent --no-interaction && npm run dev --silent --no-interaction &
php artisan migrate

php artisan vendor:publish --tag=fortify-config

sed -i '' 's/'\''views'\'' => true,/'\''views'\'' => false,/' config/fortify.php

sed -i '' 's/Features::registration(),/\/\/Features::registration(),/' config/fortify.php
sed -i '' 's/Features::resetPasswords(),/\/\/Features::resetPasswords(),/' config/fortify.php


cd ../../

# Call the external script to setup DevDojo Auth
./scripts/setup-devdojo-auth.sh jetstream

cd apps/jetstream

# Startup the server on localhost
php artisan serve

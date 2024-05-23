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

# Replace the User model content with the new inheritance from Devdojo\Auth\Models\User
sed -i '' 's/Illuminate\\Foundation\\Auth\\User as Authenticatable/Devdojo\\Auth\\Models\\User as AuthUser/' app/Models/User.php
sed -i '' 's/class User extends Authenticatable/class User extends AuthUser/' app/Models/User.php

sed -i '' 's/MAIL_MAILER=log/MAIL_MAILER=smtp/' .env
sed -i '' 's/MAIL_USERNAME="Laravel"/MAIL_USERNAME=null/' .env

# Startup the server on localhost
php artisan serve

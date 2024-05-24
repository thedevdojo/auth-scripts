#!/bin/bash

## Get the first argument as the folder name otherwise just use laravel
folder_name=${1:-laravel}

# Change to the project directory
cd apps/$folder_name

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
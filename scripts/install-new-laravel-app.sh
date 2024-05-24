#!/bin/bash

## Get the first argument as the folder name otherwise just use laravel
folder_name=${1:-laravel}

if [ ! -d "apps" ]; then
    mkdir apps
fi

## CD into the apps directory
cd apps

# Remove the existing laravel project directory
rm -rf $folder_name

# Create a new Laravel project
laravel new $folder_name --no-interaction
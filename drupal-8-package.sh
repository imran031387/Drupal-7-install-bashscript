#!/bin/bash

# Directories
##########################################################
httpDir="/Users/mimran/Projects/"
rootDir="stretch-film-8" #leave blank to set http directory as root directory.
##########################################################

# Site
##########################################################
siteName="Stretch Film"
siteSlogan=""
siteLocale="gb"
##########################################################

# Database
# for my sql change the dbDriver to "mysql"
##########################################################
dbDriver="mysql"
dbHost="127.0.0.1"
dbName="stretch_film_8_db"
dbUser="root"
dbPassword="root"
##########################################################

# Admin
##########################################################
AdminUsername="admin"
AdminPassword="password"
adminEmail="admin@example.com"
##########################################################

# Download Core
##########################################################
drush dl drupal-8.3.7 -y --destination=$httpDir --drupal-project-rename=$rootDir;

cd $httpDir/$rootDir;

# Create database
##########################################################
drush sql-create  --db-url="$dbDriver://$dbUser:$dbPassword@$dbHost/$dbName"


# Install core
##########################################################
drush site-install -y standard --account-mail=$adminEmail --account-name=$AdminUsername --account-pass=$AdminPassword --site-name=$siteName --site-mail=$adminEmail --db-url=$dbDriver://$dbUser:$dbPassword@$dbHost/$dbName;


echo -e "////////////////////////////////////////////////////"
echo -e "// Install Completed"
echo -e "////////////////////////////////////////////////////"
while true; do
    read -p "press enter to exit" yn
    case $yn in
        * ) exit;;
    esac
done


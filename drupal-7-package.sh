#!/bin/bash

# Directories
##########################################################
httpDir="/Users/mimran/Projects/"
rootDir="drupal-7-pgsql-demo" #leave blank to set http directory as root directory.
##########################################################

# Site
##########################################################
siteName="Drupal PGSQL Site"
siteSlogan="Drupal PGSQL Demo "
siteLocale="gb"
##########################################################

# Database
# for my sql change the dbDriver to "mysql"
##########################################################
dbDriver="pgsql"
dbHost="127.0.0.1:5433"
dbName="drupal_7_pgsql_db"
dbUser="mimran"
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
drush dl drupal-7.44 -y --destination=$httpDir --drupal-project-rename=$rootDir;

cd $httpDir/$rootDir;

# Create database
##########################################################
drush sql-create  --db-url="$dbDriver://$dbUser:$dbPassword@$dbHost/$dbName"


# Install core
##########################################################
drush site-install -y standard --account-mail=$adminEmail --account-name=$AdminUsername --account-pass=$AdminPassword --site-name=$siteName --site-mail=$adminEmail --locale=$siteLocale --db-url=$dbDriver://$dbUser:$dbPassword@$dbHost/$dbName;

# Download modules and themes
##########################################################
drush -y dl \
ctools \
views \
token \
fences \
metatag \
module_filter \
redirect \
globalredirect \
entity \
views_bulk_operations \
features \
strongarm \
boost \
field_group \
menu_block \
devel \
httprl \
xmlsitemap \
pathauto \
admin_menu \
google_analytics \
backup_migrate \
jquery_update \
webform \


zen;

# Disable some core modules
##########################################################
drush -y dis \
color \
toolbar \
shortcut \
search;

# Enable modules
##########################################################
drush -y en \
views \
views_ui \
token \
fences \
metatag \
module_filter \
redirect \
features \
strongarm \
globalredirect \
views_bulk_operations \
entity \
devel \
field_group \
devel_generate \
xmlsitemap \
pathauto \
admin_menu \
backup_migrate \
jquery_update \
webform \
googleanalytics \
admin_menu \
admin_menu_toolbar \
file_entity \
zen;

# Pre configure settings
##########################################################
# disable user pictures
drush vset -y user_pictures 0;
# allow only admins to register users
drush vset -y user_register 0;
# set site slogan
drush vset -y site_slogan $siteSlogan;

# Configure JQuery update
drush vset -y jquery_update_compression_type "min";
drush vset -y jquery_update_jquery_cdn "google";
drush -y eval "variable_set('jquery_update_jquery_version', strval(1.7));"

echo -e "////////////////////////////////////////////////////"
echo -e "// Install Completed"
echo -e "////////////////////////////////////////////////////"
while true; do
    read -p "press enter to exit" yn
    case $yn in
        * ) exit;;
    esac
done


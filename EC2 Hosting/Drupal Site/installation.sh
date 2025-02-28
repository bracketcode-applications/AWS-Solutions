# Update System Packages
sudo apt update && sudo apt upgrade -y

# Install Apache, MySQL, and PHP
sudo apt install -y apache2 mysql-server php php-cli php-mysql php-gd php-xml php-mbstring php-curl unzip

#Enable and start Apache:
sudo systemctl enable apache2
sudo systemctl start apache2

#Secure MySQL installation:
sudo mysql_secure_installation

#ALIDATE PASSWORD COMPONENT can be used to test passwords
# and improve security. It checks the strength of password
# and allows the users to set only those passwords which are
# secure enough. Would you like to setup VALIDATE PASSWORD component?

# Press y|Y for Yes, any other key for No: y

# There are three levels of password validation policy:
# LOW    Length >= 8
# MEDIUM Length >= 8, numeric, mixed case, and special characters
# STRONG Length >= 8, numeric, mixed case, special characters and dictionary
# Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 2 <= Recommended


# Create a Database for Drupal. Log into MySQL
sudo mysql -u root -p

# Create a password of your choosing...
# Enter a password: My!$afePas$

#Create the database and user.
CREATE DATABASE drupaldb;
CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY 'drupaluserpassword';
GRANT ALL PRIVILEGES ON drupaldb.* TO 'drupaluser'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Install Drupal. Navigate to the Apache root directory
cd /var/www/html

# Download and extract Drupal
sudo wget https://www.drupal.org/download-latest/tar.gz -O drupal.tar.gz
sudo tar -xvf drupal.tar.gz
sudo mv drupal-* drupal

# Set permissions
sudo chown -R www-data:www-data /var/www/html/drupal
sudo chmod -R 755 /var/www/html/drupal

# Configure Apache
sudo nano /etc/apache2/sites-available/drupal.conf

# Apache Config
<VirtualHost *:80>
    ServerAdmin admin@my-site.com
    DocumentRoot /var/www/html/drupal
    ServerName my-site.com

    <Directory /var/www/html/drupal>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

# Save and exit (CTRL+X, Y, Enter).

# Enable the site and rewrite module.
sudo a2ensite drupal.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

# Complete Installation
# Open your browser and go to: http://your-ec2-public-ip
# Follow the Drupal installation steps:
# Choose a language.
# Select the installation profile.
# Enter database details (drupaldb, drupaluser, drupaluserpassword).
# Site Name: Your-Site.com
# Site Email drupal@Your-Site.com
# Admin User: admin
# Admin Pass: My!DrupalAdminPa$s
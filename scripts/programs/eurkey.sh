#!/bin/bash

echo "Installing EurKEY"
wget -nv -O - https://eurkey.steffen.bruentjen.eu/download/debian/repo/conf/eurkey.gpg.key | apt-key add -
echo deb https://eurkey.steffen.bruentjen.eu/download/debian/repo stable main | sh -c 'cat > /etc/apt/sources.list.d/eurkey.steffen.bruentjen.de.sources.list'
apt-get update

apt-get install eurkey
setxkbmap eurkey
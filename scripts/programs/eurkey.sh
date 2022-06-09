#!/bin/bash

echo "🐋 Installing EurKEY"
wget -nv -O - https://eurkey.steffen.bruentjen.eu/download/debian/repo/conf/eurkey.gpg.key | sudo apt-key add -
echo deb https://eurkey.steffen.bruentjen.eu/download/debian/repo stable main | sudo sh -c 'cat > /etc/apt/sources.list.d/eurkey.steffen.bruentjen.de.sources.list'
sudo apt-get update
sudo apt-get install eurkey
setxkbmap eurkey



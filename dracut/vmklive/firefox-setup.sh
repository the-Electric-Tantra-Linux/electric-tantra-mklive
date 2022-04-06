#!/bin/sh -x

# start firefox to create a profile, imperfect but its what it is
sudo -H -u anon bash -c "firefox &"
# run the installer script itself
sudo -H -u anon bash -c "cd ~ && curl -o-  https://raw.githubusercontent.com/Thomashighbaugh/firefox/main/install.sh | bash"

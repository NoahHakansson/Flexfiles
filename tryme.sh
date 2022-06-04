#!/bin/sh
useradd -r -m -s /usr/bin/zsh testUser
passwd -d testUser
NEWUSER='testUser'
echo "$NEWUSER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$NEWUSER && chmod 0440 /etc/sudoers.d/$NEWUSER
git clone https://github.com/NoahHakansson/Flexfiles.git /home/testUser/Flexfiles/
cd /home/testUser/Flexfiles/
stow */
chown -R testUser /home/testUser/
su testUser
echo "Thank you for testing!!"


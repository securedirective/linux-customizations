#!/usr/bin/env bash

# Move this entire folder from the old location to the new
if [ -e "/usr/share/linux-customizations" ]; then
    echo -e "\nMoving directory"
    sudo mv /usr/share/linux-customizations /usr/local/etc/ || exit 1
fi
echo -e "\nFixing current .bashrc on root user"
sed -i 's/\/usr\/share\/linux-customizations/\/usr\/local\/etc\/linux-customizations/' ~/.bashrc || exit 1
echo -e "\nRunning install.sh on current user"
/usr/local/etc/linux-customizations/install.sh || exit 1

echo -e "\nFixing .bashrc on root user"
sudo su root -c "sed -i 's/\/usr\/share\/linux-customizations/\/usr\/local\/etc\/linux-customizations/' ~/.bashrc" || exit 1
echo -e "\nRunning install.sh on root user"
sudo su root -c "/usr/local/etc/linux-customizations/install.sh" || exit 1

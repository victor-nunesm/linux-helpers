#!/bin/bash

#setup folders
mkdir /home/$USER/.local/share/custom-scripts
mkdir /home/$USER/.local/share/custom-scripts/icons
cp ./*.svg /home/$USER/.local/share/custom-scripts/icons

#Bluetooth Settings
echo "#!/bin/bash
gnome-control-center bluetooth &" > /home/$USER/.local/share/custom-scripts/open-bluetooth-settings.sh
chmod 777 /home/$USER/.local/share/custom-scripts/open-bluetooth-settings.sh

echo "[Desktop Entry]
Type=Application
Terminal=false
Name=Open Bluetooth
Icon=/home/$USER/.local/share/custom-scripts/icons/bluetooth.svg
Exec=/home/$USER/.local/share/custom-scripts/open-bluetooth-settings.sh" > "/home/$USER/.local/share/custom-scripts/Open Bluetooth.desktop"

#Chrome Debugger
echo "#!/bin/bash
google-chrome --remote-debugging-port=9222 &" > /home/$USER/.local/share/custom-scripts/open-chrome-debug.sh
chmod 777 /home/$USER/.local/share/custom-scripts/open-chrome-debug.sh

echo "[Desktop Entry]
Type=Application
Terminal=false
Name=Chrome Debugger
Icon=/home/$USER/.local/share/custom-scripts/icons/chrome-dev.svg
Exec=/home/$USER/.local/share/custom-scripts/open-chrome-debug.sh" > "/home/$USER/.local/share/custom-scripts/Chrome Debugger.desktop"

cp /home/$USER/.local/share/custom-scripts/*.desktop /home/$USER/.local/share/applications

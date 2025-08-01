# Exit immediately if a command exits with a non-zero status
set -e

# Install everything
for f in ~/comical/install/*.sh; do source "$f"; done

# Ensure locate is up to date now that everything has been installed
sudo updatedb

gum confirm "Reboot to apply all settings?" && reboot

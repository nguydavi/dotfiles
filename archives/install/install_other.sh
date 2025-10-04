#!/bin/bash

source ./install/base_install.sh

echo
cat << EOM
The following need manual installation depending on the platform
* Nerd font https://github.com/ryanoasis/nerd-fonts/releases 'FantasqueSansMono'
* YouCompleteMe https://github.com/ycm-core/YouCompleteMe#installation
* Ripgrep https://github.com/BurntSushi/ripgrep#installation
* termshark https://github.com/gcla/termshark#install-packages
* lsd https://github.com/Peltoche/lsd#installation
* jq https://github.com/stedolan/jq
* glances https://github.com/nicolargo/glances#installation
EOM
# Can look for other useful tools at https://github.com/ibraheemdev/modern-unix
echo_green "All done!"

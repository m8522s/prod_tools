#!/bin/bash
# $RCSfile: install.sh,v $ $Date: 2021/08/15 19:41:19 $ $Revision: 2.14 $

# purpose: install the productivity tools in the local file system
# note: it is safe to run this script multiple times

PROD_FILES="dist collect maintenance doc"
for TOOL in $PROD_FILES ; do
  install --mode=755 $TOOL /usr/bin/
done

# quick commands for bash (add only when not present)
grep '# productivity_tools' ~/.bashrc >/dev/null
if [ $? -eq 0 ] ; then
  echo "# productivity_tools" >> ~/.bashrc
  echo ". ~/.bash_ptools"     >> ~/.bashrc
  install --mode=755 bashrc ~/.bash_ptools
fi

# documentation
mkdir /usr/share/doc/prodtools/
install --mode=644 README /usr/share/doc/prodtools/
install --mode=644 ChangeLog /usr/share/doc/prodtools/

# CVS commands for vim
mkdir -p /usr/src/vcscommand
cd /usr/src/vcscommand
wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/vcscommand/vcscommand-1.99.47.zip
unzip -q vcscommand-1.99.47.zip
install --mode=644 plugin/*.vim -t /usr/share/vim/vim??/plugin/
install --mode=644 syntax/*.vim -t /usr/share/vim/vim??/syntax/
install doc/vcscommand.txt /usr/share/vim/vim??/doc
cat <<EOF >> .vimrc
" cvs shortcut commands (by prodtools 0.2)
" see /usr/share/vim/vim??/doc/doc/vcscommand.txt 
command Cvsc VCSCommit
command Cvsd VCSDiff
command Cvsa VCSAdd
EOF

exit 0

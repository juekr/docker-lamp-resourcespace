#!/bin/bash
apt-get install mlocate
updatedb
a2epath=`locate a2enmod`
export PATH=${PATH:+$PATH:}${a2epath}

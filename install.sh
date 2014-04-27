#!/bin/bash
pwd=$(pwd)
for i in $(ls -A)
do
if [ $i != ".git" ] && [ $i != "install.sh" ]
then
pushd ./ >/dev/null
cd ~
echo $i
if [ -z $(ls -a|grep $i) ];then
ln -s $pwd/$i
echo "Symlink for $i created"
else
echo "$i already exists, be it a physical file or a symlink. rm it, and try again."
fi
popd >/dev/null
fi
done

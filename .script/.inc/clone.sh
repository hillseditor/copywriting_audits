#!/bin/sh
dirs='.git .gitignore Dockerfile docker-compose.yml setup.sh cp.sh down.sh cascade.sh wroot README.md dp.sh build.sh src readme.md update.sh .gitlab-ci.yml'
mkdir  -p tmp && cd tmp
git clone  git@gitlab.com:hillseditor/hesdp.git .
rm -rf ${dirs}
ls -al
rsync -a  ./ ../
cd .. && rm -fr tmp
mkdir -p tmp && cd tmp
git clone  git@gitlab.com:hillseditor/hesos.git .
rm -rf ${dirs}
ls -al
rsync -a  ./ ../
cd .. && rm -fr tmp

#!/bin/sh

XTUPLE_DIR=/home/vagrant/source/xtuple/

cd $XTUPLE_DIR
git fetch XTUPLE
git merge XTUPLE/master
git submodule update --init --recursive
npm install

@echo off
pushd "%~dp0"
ruby -Ke -I bitclust/lib bitclust/bin/refe -d db-1_9_3 -e sjis %*
popd

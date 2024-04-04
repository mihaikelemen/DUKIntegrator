#!/bin/bash
# Build script for DUKIntegrator
# Required: wget, unzip
# This script is used to build the project and create the distribution package
# @Author: Mihai KELEMEN <mihai@webmanage.ro>

DUKIntegratorURL=https://static.anaf.ro/static/DUKIntegrator/dist_javaInclus20200203.zip
VERSION=1.1

wget $DUKIntegratorURL -O DUKIntegrator.zip && unzip -qq DUKIntegrator.zip -d $PWD && rm DUKIntegrator.zip
docker build --no-cache -t dukintegrator:$VERSION -f ./Dockerfile .
docker save -o ./dukintegrator-v$VERSION.tar.gz dukintegrator:$VERSION

# cleanup
rm -rf ./dist

# Exit with success status
exit 0
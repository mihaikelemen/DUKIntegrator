#!/bin/bash
# Build script for DUKIntegrator
# Required: wget, unzip
# This script is used to build the project and create the distribution package
# @Author: Mihai KELEMEN <mihai@webmanage.ro>

DUKIntegratorURL=https://static.anaf.ro/static/DUKIntegrator/dist_javaInclus20200203.zip
D112URL=https://static.anaf.ro/static/10/Anaf/Declaratii_R/AplicatiiDec/D112_16052024.zip
D100URL=https://static.anaf.ro/static/10/Anaf/Declaratii_R/AplicatiiDec/D100_11072024.zip
VERSION=1.6

wget $DUKIntegratorURL -O DUKIntegrator.zip && unzip -qq DUKIntegrator.zip -d $PWD && rm DUKIntegrator.zip
cp ./dist/lib/* ./lib
mkdir -p $PWD/tmp
wget $D112URL -O ./tmp/D112.zip && unzip -qq ./tmp/D112.zip -d ./tmp && mv ./tmp/D112*.jar
wget $D100URL -O ./tmp/D100.zip && unzip -qq ./tmp/D100.zip -d ./tmp && mv ./tmp/D100*.jar
docker build --no-cache -t dukintegrator:$VERSION -f ./Dockerfile .
docker save -o ./dukintegrator-v$VERSION.tar.gz dukintegrator:$VERSION
rm -rf ./tmp/*

# cleanup
rm -rf ./dist

# Exit with success status
exit 0

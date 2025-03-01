#!/bin/bash
if [ -z $1 ]
then
    echo "apk appbundle"
    exit 0
fi
flutter build $1
#!/bin/bash
if [ -z $1 ]
then
    echo "apk appbundle"
    exit 0
fi
flutter build $1 --bundle-sksl-path flutter_01.sksl.json --no-tree-shake-icons

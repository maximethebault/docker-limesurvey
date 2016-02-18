#!/usr/bin/env bash

# on utilise le switch p pour préserver les droits
cp -pR /uploadstruct/* /app/upload
rm -Rf /uploadstruct/

/run.sh
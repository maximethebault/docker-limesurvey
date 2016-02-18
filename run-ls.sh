#!/bin/bash

# on utilise le switch p pour préserver les droits
cp -pR /uploadstruct/* /app/upload
rm -Rf /uploadstruct/

# on utilise le switch n pour ne pas effacer les fichiers de configuration déjà présents
cp -pnR /configstruct/* /app/application/config
rm -Rf /configstruct/

/run.sh
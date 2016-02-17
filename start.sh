#! /bin/bash

chown -R www-data:www-data /app/upload/
chmod -R u+w,g+w,o+w /app/upload/

./run.sh
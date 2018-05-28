#! /bin/bash

if [ ! -f /Comics/index.php ]; then
  cp /templates/redirect.php /Comics/index.php
fi

/usr/sbin/crond -f -l 8
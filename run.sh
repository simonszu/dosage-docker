#! /bin/bash

if [ ! -f /Comics/index.php ]; then
  cp /templates/redirect.php /Comics/index.php
fi

cron -f && tail -f /var/log/cron.log
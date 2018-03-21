#! /bin/bash

if [ ! -f /Comics/index.php ]; then
  cp /index.php /Comics/index.php
fi

cron -f
#!/bin/sh

echo "mayan-edms: run_all"

rm --force /var/run/supervisor.sock
/usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf --nodaemon

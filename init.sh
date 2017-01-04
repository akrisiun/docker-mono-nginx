#!/usr/local/bin/dumb-init /bin/sh

/usr/bin/fastcgi-mono-server4 /applications=/:/var/wwwroot/ /socket=tcp:127.0.0.1:9000 &
/usr/local/bin/start-nginx.sh

ps -auxn
# $@

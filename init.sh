#!/usr/local/bin/dumb-init /bin/sh

# /usr/bin/fastcgi-mono-server4 /applications=/:/var/wwwroot/ /socket=tcp:127.0.0.1:9000 &

# MONO_OPTIONS="--debug" MONO_IOMAP=all 
# /usr/bin/fastcgi-mono-server4 /applications=/:/var/wwwroot/ /socket=tcp:127.0.0.1:9000 \
    # /printlog=True /loglevels=Debug &

cd /var/wwwroot
/usr/bin/xsp4 --loglevels=ALL &    

/usr/local/bin/start-nginx.sh

ps -auxn
# /etc/init.d/nginx restart
# $@

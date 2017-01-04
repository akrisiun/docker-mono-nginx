FROM mono:4.6

MAINTAINER Andrius K <akrisiun@gmail.com>

ADD init.sh /usr/local/bin/init.sh
ADD start-nginx.sh /usr/local/bin/start-nginx.sh

RUN chmod a+x /usr/local/bin/init.sh \
    && chmod a+x /usr/local/bin/start-nginx.sh \
    && apt-get update \
    && apt-get install ca-certificates wget mc git procps nginx \
       -y --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* \
    && mkdir -p /etc/mono/registry /etc/mono/registry/LocalMachine \
    && wget --ca-directory=/etc/ssl/certs -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64 \
    && chmod +x /usr/local/bin/dumb-init

ENV PKG_CONFIG_PATH /usr/lib/pkgconfig

RUN apt-get update && \
    apt-get install -y mc git autoconf libtool make less nano && \
    git clone https://github.com/akrisiun/Mono.XSP /var/xsp && \
    cd /var/xsp && \
    ./autogen.sh --prefix=/usr --disable-docs && \
    ./configure --prefix=/usr  --disable-docs && \
    make && \
    make install

ADD config/fastcgi_params /etc/nginx/fastcgi_params
ADD config/default /etc/nginx/sites-available/
EXPOSE 80
EXPOSE 9000

WORKDIR /var/wwwroot
ADD default.html /var/wwwroot/default.html
ADD index.html /var/wwwroot/index.html
ADD netversion.aspx /var/wwwroot/netversion.aspx
ADD Global.asax /var/wwwroot/Global.asax
ADD Web.config /var/wwwroot/Web.config

# ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
# ENTRYPOINT ["/usr/local/bin/dumb-init", "/usr/local/bin/init.sh"]
ENTRYPOINT ["/usr/local/bin/init.sh"]

# CMD ["/usr/local/bin/init.sh", "--with", "--args"]
# CMD ["/usr/bin/xsp4"]
CMD ["ps", "-auxn"]

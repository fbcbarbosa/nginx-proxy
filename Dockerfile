FROM nginx:1.13-alpine
LABEL maintainer="fbcbarbosa@gmail.com"

RUN set -x && \
    apk add --update libintl && \
    apk add --virtual build_deps gettext &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

ADD nginx.conf.tmpl .
ENTRYPOINT ["/bin/sh", "-c", \
	"envsubst '$PROXY_SERVER $PROXY_PASS $PROXY_AUTH' < nginx.conf.tmpl > /etc/nginx/nginx.conf; nginx -g 'daemon off;'"]


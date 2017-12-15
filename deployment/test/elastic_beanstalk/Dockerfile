# use Ubuntu Xenial, the latest LTS release
FROM ubuntu:16.04

EXPOSE 80

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		nginx \
	&& echo "daemon off;" >> /etc/nginx/nginx.conf

COPY index.html /var/www/html/

CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]

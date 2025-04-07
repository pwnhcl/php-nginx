FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic packages
RUN apt-get update && apt-get install -y \
    software-properties-common curl gnupg2 ca-certificates lsb-release wget

# Add PHP PPA (for 8.0.24)
RUN add-apt-repository ppa:ondrej/php -y

# Add official Nginx signing key and repo for version 1.18.0
RUN wget https://nginx.org/keys/nginx_signing.key && apt-key add nginx_signing.key && \
    echo "deb http://nginx.org/packages/ubuntu focal nginx" > /etc/apt/sources.list.d/nginx.list

# Install PHP 8.0.24 + Nginx 1.18.0 + Supervisor
RUN apt-get update && apt-get install -y \
    apt-utils\
    php8.0 php8.0-fpm php8.0-mysql php8.0-zip php8.0-cli php8.0-curl \
    php8.0-gd php8.0-mbstring php8.0-xml php8.0-bcmath php8.0-soap php8.0-intl \
    nginx=1.18.0-1~focal \
    mysql-client supervisor && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Nginx config
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/default.conf /etc/nginx/conf.d/

# Document root
WORKDIR /var/www/html
COPY src/ /var/www/html/

EXPOSE 80

CMD ["/usr/bin/supervisord"]

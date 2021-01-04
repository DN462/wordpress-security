FROM debian:latest
LABEL org.label-schema.name="docker-bench-security" \
      org.label-schema.url="https://github.com/konstruktoid/docker-bench-security" \
      org.label-schema.vcs-url="https://github.com/konstruktoid/docker-bench-security.git"
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl apache2 unzip composer libapache2-mod-security2 libapache2-mod-evasive libapache2-mod-php7.3 php7.3 php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-common php7.3-curl php7.3-fpm php7.3-gd php-imagick php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-readline php-redis php7.3-soap php7.3-xml php7.3-zip openssl wget iptables git
RUN cd /home
RUN mkdir holding
RUN cd holding/
RUN cd /home
RUN rm -rf holding/
RUN cd /var/www/
RUN wget https://wordpress.org/latest.zip
RUN unzip latest.zip -d /var/www/html
RUN rm latest.zip
RUN cp -rf /var/www/html/wordpress/* /var/www/html
RUN rm -rf /var/www/html/wordpress
RUN composer require vlucas/phpdotenv
RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install auditd ca-certificates docker.io \
      gawk iproute2 procps --no-install-recommends && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* \
      /usr/share/doc /usr/share/doc-base \
      /usr/share/man /usr/share/locale /usr/share/zoneinfo
RUN mkdir /docker-bench-security
COPY . /docker-bench-security
WORKDIR /docker-bench-security
ENTRYPOINT ["/bin/sh", "docker-bench-security.sh"]
FROM debian:latest
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y curl apache2 unzip composer libapache2-mod-security2 libapache2-mod-evasive libapache2-mod-php7.3 php7.3 php7.3-bcmath php7.3-bz2 php7.3-cgi php7.3-cli php7.3-common php7.3-curl php7.3-fpm php7.3-gd php-imagick php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-readline php-redis php7.3-soap php7.3-xml php7.3-zip openssl wget iptables git
RUN cd /home
RUN mkdir holding
RUN cd holding/
RUN curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
RUN git clone https://github.com/dev-sec/cis-docker-benchmark
RUN inspec exec cis-docker-benchmark
RUN cd /home
RUN rm -rf holding/
RUN cd /var/www/html
RUN wget https://wordpress.org/latest.zip
RUN unzip latest.zip
RUN cd wordpress
RUN cp -rf * ../
RUN cd ../
RUN rm -rf wordpress/ latest.zip
RUN cd ../
RUN composer require vlucas/phpdotenv
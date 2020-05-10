FROM centos:7
RUN yum -y update && yum clean all
RUN yum -y install php-fpm php-mbstring php-mysql php-gd && yum clean all
RUN sed 's/127.0.0.1:9000/9000/' -i /etc/php-fpm.d/www.conf
RUN sed '/allowed_clients/d' -i /etc/php-fpm.d/www.conf
RUN sed '/catch_workers_output/s/^;//' -i /etc/php-fpm.d/www.conf
RUN ln -sf /proc/self/fd/1 /var/log/php-fpm/www-slow.log && \
    ln -sf /proc/self/fd/1 /var/log/php-fpm/www-error.log
RUN mkdir -p /var/www/html
CMD ["/usr/sbin/php-fpm", "--nodaemonize"]

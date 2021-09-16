FROM bitnami/php-fpm:8.0

RUN apt update && apt -y install zip unzip git-all
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ADD guestbook.php /app/guestbook.php
ADD composer.json /app/composer.json
ADD controllers.js /app/controllers.js
ADD angular.min.js /app/angular.min.js
ADD ui-bootstrap-tpls.js /app/ui-bootstrap-tpls.js
ADD bootstrap.min.css /app/bootstrap.min.css
ADD index.html /app/index.html

WORKDIR /app
RUN composer update
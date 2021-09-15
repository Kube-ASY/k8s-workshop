FROM bitnami/php-fpm:8.0

RUN pear channel-discover pear.nrk.io
RUN pear install nrk/Predis

ADD guestbook.php /app/guestbook.php
ADD controllers.js /app/controllers.js
ADD angular.min.js /app/angular.min.js
ADD ui-bootstrap-tpls.js /app/ui-bootstrap-tpls.js
ADD bootstrap.min.css /app/bootstrap.min.css
ADD index.html /app/index.html

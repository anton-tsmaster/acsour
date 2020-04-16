#!/bin/bash
sed -i "s/BASE_NAME/${BASE_NAME}/" /usr/local/apache2/htdocs/base/default.vrd
exec httpd -DFOREGROUND "$@" 
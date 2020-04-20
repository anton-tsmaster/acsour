FROM httpd:2.4-alpine

ENV HTTPD_PATH /usr/local/apache2
#ENV BASE_NAME=$VAR_BASE

# Копируем дистрибутив в директорию dist
COPY setuptc.zip ${HTTPD_PATH}/htdocs/distribupd/

# Копируем внутрь контейнера заранее подготовленный конфиг от Apache
COPY httpd.conf ${HTTPD_PATH}/conf/
COPY acsour.com.cer ${HTTPD_PATH}/conf/
COPY acsour.com.key ${HTTPD_PATH}/conf/

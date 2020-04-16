FROM httpd:2.4
# Данный образ базируется на стандартном образе Debian+Apache 2.4: https://store.docker.com/images/httpd

ENV TAR_GZ=deb64_8_3_15_1830.tar.gz
ENV HTTPD_PATH /usr/local/apache2
#ENV BASE_NAME=$VAR_BASE

# Копируем дистрибутив в директорию dist
COPY ${TAR_GZ} /dist/

# Разархивируем дистрибутив
RUN tar -xzf /dist/${TAR_GZ} -C /dist \
  # и устанавливаем пакеты 1С в систему внутри контейнера
  && dpkg -i /dist/*.deb \
  # и тут же удаляем исходные deb файлы дистрибутива, которые нам уже не нужны
  && rm /dist/*.deb

# Копируем внутрь контейнера заранее подготовленный конфиг от Apache
COPY httpd.conf ${HTTPD_PATH}/conf/
COPY acsour.com.cer ${HTTPD_PATH}/conf/
COPY acsour.com.key ${HTTPD_PATH}/conf/

# Копируем внутрь контейнера заранее подготовленный конфиг с настройками подключения к серверу 1С
COPY default.vrd ${HTTPD_PATH}/htdocs/base/
COPY changevrd.sh ${HTTPD_PATH}/htdocs/base/
ENTRYPOINT ["/bin/bash"]
CMD ["/usr/local/apache2/htdocs/base/changevrd.sh"]
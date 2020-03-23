FROM bitnami/spark:2

USER root
COPY ./hail-all-spark.jar /opt/bitnami/spark/jars/hail-all-spark.jar
COPY ./spark-defaults.conf /opt/bitnamie/spark/conf/spark-defaults.conf

COPY scripts /opt/bitnami/scripts
RUN rm -rf /opt/bitnami/python
#RUN curl https://downloads.bitnami.com/files/stacksmith/python-3.7.7.prod-0-linux-amd64-debian-10.tar.gz | sha256sum
#RUN curl -O https://downloads.bitnami.com/files/stacksmith/python-3.7.7.prod-0-linux-amd64-debian-10.tar.gz
#RUN ls -lisa python*
RUN . /opt/bitnami/scripts/libcomponent.sh && component_unpack "python" "3.7.7-0" --checksum 1ab9c2edc8f4ddf396f7aa988c194a7f0c685d694cd0778ef975b38587c04d15

RUN apt-get update
RUN apt-get install -y telnet wget dnsutils
USER 1001
 

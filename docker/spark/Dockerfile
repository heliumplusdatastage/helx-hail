FROM bitnami/spark:2

COPY ./hail-all-spark.jar /opt/bitnami/spark/jars/hail-all-spark.jar
COPY ./spark-defaults.conf /opt/bitnamie/spark/conf/spark-defaults.conf

USER root
RUN apt-get update
RUN apt-get install -y telnet wget dnsutils
USER 1001
 

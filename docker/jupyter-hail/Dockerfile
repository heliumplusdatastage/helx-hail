FROM bitnami/java:1.8 AS java
FROM bitnami/python:latest AS python
LABEL maintainer "RENCI <info@renci.org>"

# Fold Java 8
COPY --from=bitnami/java:1.8 /opt/bitnami/java/ /opt/bitnami/java/
ENV JAVA_HOME="/opt/bitnami/java" \
    PATH="/opt/bitnami/java/bin:$PATH"
RUN ls /opt/bitnami

# Run as a non-root user.
COPY ./entrypoint.sh /
ENV USER jupyter-user
ENV UID 1000
ENV HOME /home/$USER
RUN useradd -m -s /bin/bash -N -u $UID $USER && \
    chown -R $USER /entrypoint.sh && \
    chmod +x /entrypoint.sh
USER $USER
WORKDIR $HOME

# Install Spark
ENV SPARK_VERSION 2.4.1
RUN wget --quiet https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz && \
    tar xvzf spark-${SPARK_VERSION}-bin-hadoop2.7.tgz && \
    ln -s spark-${SPARK_VERSION} spark && \
    export SPARK_HOME=$PWD/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

# Install requirements
COPY ./requirements.txt /home/$USER/requirements.txt
RUN python3 -m venv hail && \
    . hail/bin/activate && \
    pip install --upgrade pip && \
    pip install -r /home/$USER/requirements.txt

# Configure Jupyter port
ENV JUPYTER_PORT 8000
EXPOSE $JUPYTER_PORT
RUN echo $JUPYTER_PORT > /home/$USER/jupyter_port.ini

ENTRYPOINT [ "/entrypoint.sh", "$JUPYTER_PORT" ]

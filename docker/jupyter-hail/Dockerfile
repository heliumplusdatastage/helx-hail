FROM ubuntu:latest

RUN apt update && \
    apt -y install software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt update && \
    apt -y install python3.7 python3-venv

COPY ./entrypoint.sh /
ENV USER jupyter-user
ENV UID 1000
ENV HOME /home/$USER
RUN useradd -m -s /bin/bash -N -u $UID $USER && \
    chown -R $USER /entrypoint.sh && \
    chmod +x /entrypoint.sh

USER $USER
WORKDIR $HOME

ENV JUPYTER_PORT 8000
EXPOSE $JUPYTER_PORT
RUN echo $JUPYTER_PORT > /home/$USER/jupyter_port.ini

COPY ./requirements.txt /home/$USER/requirements.txt
RUN python3 -m venv hail && \
    . hail/bin/activate && \
    pip install -r /home/$USER/requirements.txt

ENTRYPOINT [ "/entrypoint.sh", "$JUPYTER_PORT" ]

FROM helxplatform/conda-layer

# ======================================= Hail ======================================
# https://hail.is/docs/0.2/getting_started.html
#
RUN . ~/.bashrc && \
    echo $PATH && \
    conda update --yes --freeze-installed -n base -c defaults conda && \
    conda init && \
    conda create --yes -n hail python==3.7 && \
    conda activate hail && \
    pip install --upgrade pip && \
    pip install hail && \
    pip cache purge && \
    conda clean -afy \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -follow -type f -name '*.js' ! -name '*.min.js' -delete

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENV USER jupyter-user
ENV UID 1000
ENV HOME /home/$USER
RUN useradd -m -s /bin/bash -N -u $UID $USER
#RUN chown -R $USER /opt/conda && \
#    chown -R $USER /entrypoint.sh

ENV JUPYTER_PORT 8000
RUN echo $JUPYTER_PORT > /jupyter_port.ini
USER $USER
WORKDIR $HOME
EXPOSE $JUPYTER_PORT

ENTRYPOINT [ "/entrypoint.sh", "$JUPYTER_PORT" ]

FROM jupyter/all-spark-notebook:dc9744740e12
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/recipes.html

# name your environment and choose python 3.x version
ARG conda_env=python36
ARG py_ver=3.6

USER root

# Install nb_conda in the base environment.
RUN conda install nb_conda_kernels ipykernel && \
        conda install --quiet --yes -c conda-forge minio ipyleaflet seaborn && \
	python -m IPython kernel install --prefix=/usr/local --name "Python3.7"

# you can add additional libraries you want conda to install by listing them below the first line and ending with "&& \"
RUN conda create --quiet --yes -p $CONDA_DIR/envs/$conda_env python=$py_ver ipykernel ipython && \
    conda clean --all -f -y

# create Python 3.x environment and link it to jupyter
RUN $CONDA_DIR/envs/${conda_env}/bin/python -m ipykernel install --user --name=${conda_env} && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

COPY core-site.xml $SPARK_HOME/conf
COPY alluxio-2.2.0-client.jar $SPARK_HOME/jars
RUN wget --quiet --timestamping \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar \
        -P $SPARK_HOME/jars/ && \
        wget --quiet --timestamping \
        https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar \
        -P $SPARK_HOME/jars/

# prepend conda environment to path
ENV PATH $CONDA_DIR/envs/${conda_env}/bin:$PATH

# if you want this environment to be the default one, uncomment the following line:
ENV CONDA_DEFAULT_ENV ${conda_env}

RUN . $CONDA_DIR/etc/profile.d/conda.sh && \
        conda deactivate && \
        conda activate $conda_env && \
        conda install nb_conda_kernels ipykernel && \
        python -m IPython kernel install --prefix=/usr/local --name "Python3.6"

RUN conda install --quiet --yes -c conda-forge ipyleaflet && \
    conda install --quiet --yes seaborn && \
    conda install --quiet --yes \
        'notebook=6.0.3' \
        'jupyterhub=1.1.0' \
        'jupyterlab=2.0.1' && \
        conda clean --all -f -y && \
        npm cache clean --force && \
        conda install --quiet --yes -c conda-forge minio && \
        jupyter notebook -y --generate-config && \
        rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
        rm -rf /home/$NB_USER/.cache/yarn && \
        fix-permissions $CONDA_DIR && \
        fix-permissions /home/$NB_USER

USER $NB_UID

FROM jupyter/all-spark-notebook:dc9744740e12
# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/recipes.html

USER root

# Start in the default Python3.7 environment.
# Install nb_conda in the base environment.
# Add dependencies for connectivity to other systems and visualization:
#   Minio needs to be at 5.0.6 for Python 3.7
RUN conda install nb_conda_kernels ipykernel && \
	python -m IPython kernel install --prefix=/usr/local --name "Python3.7" && \
	python -m pip install ipyleaflet seaborn minio==5.0.6

# Update Spark to include Alluxio bindings.
COPY core-site.xml $SPARK_HOME/conf
COPY alluxio-2.2.0-client.jar $SPARK_HOME/jars
RUN wget --quiet --timestamping \
        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar \
        -P $SPARK_HOME/jars/ && \
        wget --quiet --timestamping \
        https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar \
        -P $SPARK_HOME/jars/ && \
        git clone https://github.com/stevencox/blackbalsam.git $HOME/blackbalsam && \
        export PYTHONPATH=$PYTHONPATH:$HOME/blackbalsam && \
        pip install --upgrade tensorflow keras gensim # sklearn numpy torch
#        git clone https://github.com/thunlp/OpenKE.git && \
#        cd  OpenKE/openke && \
#        ./make.sh && \
#        cd .. && \

USER $NB_UID

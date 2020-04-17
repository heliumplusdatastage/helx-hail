FROM jupyter/all-spark-notebook:dc9744740e12

USER root
    
################################################################################################
##
## Start in the default Python3.7 environment.
##
## Install nb_conda in the base environment.
## Add dependencies for connectivity to other systems and visualization:
##  Minio needs to be at 5.0.6 for Python 3.7
##
##
##################################################################################################
RUN conda install nb_conda_kernels ipykernel && \
	python -m IPython kernel install --prefix=/usr/local --name "Python3.7" && \
	python -m pip install ipyleaflet seaborn minio==5.0.6 \
	requests==2.22.0 neo4jrestclient==2.1.1 elasticsearch==7.5.1

################################################################################################
##
## Update Spark to include Alluxio bindings and configure the alluxio protocol.
##
################################################################################################
COPY core-site.xml $SPARK_HOME/conf
COPY alluxio-2.2.0-client.jar $SPARK_HOME/jars

################################################################################################
##
## Install
##   * AWS S3 client libs.
##   * Minio CLI client
##   * Blackbalsam repo
##   * Set PYTHONPATH
##   * Install AI toolkit
##
################################################################################################

COPY ./config_spark.sh /
RUN ls -lisa /
RUN chmod +x /config_spark.sh && \
    /config_spark.sh get_spark_deps

#RUN wget --quiet --timestamping \
#        https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.3/hadoop-aws-2.7.3.jar \
#        -P $SPARK_HOME/jars/ && \
#        wget --quiet --timestamping \
#        https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar \
#        -P $SPARK_HOME/jars/ && \

RUN wget --quiet https://dl.min.io/client/mc/release/linux-amd64/mc -O /usr/local/bin/mc && \
	chmod +x /usr/local/bin/mc && \
        git clone https://github.com/stevencox/blackbalsam.git $HOME/blackbalsam && \
        pip install --upgrade tensorflow keras gensim sklearn numpy torch && \
        git clone https://github.com/thunlp/OpenKE.git && \
        cd  OpenKE/openke && \
        ./make.sh

USER $NB_UID

RUN export PYTHONPATH=$PYTHONPATH:$HOME/blackbalsam:/home/shared/blackbalsam/blackbalsam
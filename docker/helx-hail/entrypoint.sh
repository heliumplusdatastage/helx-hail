#!/bin/bash

. /opt/conda/etc/profile.d/conda.sh
JUPYTER_PORT=$(cat /jupyter_port.ini)
NB_PREFIX=${NB_PREFIX}
export PATH=/opt/conda/bin/:$PATH
conda init bash
conda activate hail
python -m ipykernel install --user --name hail --display-name "Hail-Python3"
jupyter lab --ip=0.0.0.0 --port=$JUPYTER_PORT --LabApp.token= --NotebookApp.base_url=${NB_PREFIX} --NotebookApp.allow_origin="*"

#!/bin/bash

JUPYTER_PORT=$(cat ~/jupyter_port.ini)
. ~/hail/bin/activate
python -m ipykernel install --user --name hail --display-name "Hail-Python3"
jupyter lab --ip=0.0.0.0 --port=$JUPYTER_PORT --LabApp.token=

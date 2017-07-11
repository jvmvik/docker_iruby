#FROM jupyter/minimal-notebook
FROM kozo2/iruby-notebook

MAINTAINER Victor Benarbia <victor@vtool.run>

USER root

RUN apt-get update && \
    apt-get install -yq gnuplot-nox && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
RUN gem install numo-gnuplot

# Switch back to basic user
USER $NB_USER

COPY profile/*.py /home/$NB_USER/.ipython/profile_default/

VOLUME /data

WORKDIR /data
#RUN iruby --force register
#RUN jupyter notebook

#--force register
#/home/jovyan/.ipython/kernels/ruby/kernel.json

#
# docker build -t vtool.run/iruby .
# docker run -d -v `pwd`/data:/data -p 8888:8888 vtool.run/iruby start-notebook.sh --NotebookApp.token='' --notebook-dir=/data

# Automate image creation
#

# Get current docker ID
did=`docker ps | grep vtool.run/iruby | cut -d' ' -f1`

ifeq ($(did),)
all: build start
else
all: stop build start
endif

build:
	@echo "Build image"
	docker build -t vtool.run/iruby .

start:
	@echo "Start image"
	docker run -d -v `pwd`/data:/data -p 8888:8888 vtool.run/iruby start-notebook.sh --NotebookApp.token='' --notebook-dir=/data

stop:
	@echo "Stop if running: $(did)"
	docker stop $(did) 

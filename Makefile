.PHONY: all
all: container

.PHONY: container
container:
	docker build -t data .

.PHONY: run
run:
	docker run -d -p 5432:5432 --hostname=data --name=data data

.PHONY: debug
debug:
	docker run -i -t -p 5432:5432 --hostname=data --name=data data

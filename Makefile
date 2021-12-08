IMAGE = jordanjunn/logrotate
TAG = latest

CRON_SCHEDULE ?= * * * * *

build:
	docker build -t $(IMAGE):$(TAG) .

push:
	docker push $(IMAGE):$(TAG) 

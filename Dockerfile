FROM ubuntu:20.04 

RUN apt-get update
RUN apt-get install -y \
	unzip \
    curl \
    && curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o "awscli-v2.zip" \
	&& unzip awscli-v2.zip \
	&& ./aws/install
    

ENV CRON_SCHEDULE='0 * * * *' \
	LOGROTATE_INTERVAL='daily' \
	LOGROTATE_PATTERN='/logs/*.log' \
	LOGROTATE_ROTATE='0'

RUN apt-get install -y logrotate \
    && mkdir -p /logs \
    && mkdir -p /etc/logrotate.d

COPY --from=hairyhenderson/gomplate:stable /gomplate /bin/gomplate
COPY logrotate.tpl.conf /logrotate.tpl.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


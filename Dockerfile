FROM python:alpine

ENV TZ=Europe/Berlin

RUN apk --no-cache add \
    bash \
    build-base \
    git \ 
    libxml2 \
    libxml2-dev \
    && git clone https://github.com/webcomics/dosage.git \
    && cd dosage \
    && pip install --no-cache-dir -r requirements.txt \
    && /usr/local/bin/python setup.py install \
    && cd / \
    && rm -r dosage \
    && apk del \
    build-base \
    git \
    libxml2-dev

RUN mkdir /Comics && mkdir /templates
COPY download.sh .
COPY crontab.txt .
COPY run.sh .

COPY redirect.php /templates
COPY index.php /templates
RUN chmod +x download.sh && chmod +x run.sh
RUN /usr/bin/crontab /crontab.txt

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

ENTRYPOINT ["/run.sh"]
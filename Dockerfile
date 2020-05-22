FROM python:buster

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -y cron \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/webcomics/dosage.git \
    && cd dosage \
    && pip install --no-cache-dir -r requirements.txt \
    && /usr/local/bin/python setup.py install \
    && cd / \
    && rm -r dosage

# Create dirs
RUN mkdir /Comics && mkdir /templates

# Copy script for downloading
COPY download.sh .

# Copy files for web serving
COPY redirect.php /templates
COPY index.php /templates

# Copy entrypoint script
COPY run.sh .

# Make download and entrypoint script executable
RUN chmod +x download.sh && chmod +x run.sh

# Copy cron definition and make it executable
COPY dosage-cron /etc/cron.d/
RUN chmod +x /etc/cron.d/dosage-cron

# Apply cron job
RUN crontab /etc/cron.d/dosage-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

ENTRYPOINT ["/run.sh"]

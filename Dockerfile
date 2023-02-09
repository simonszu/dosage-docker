FROM python:bullseye

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Cron
RUN apt-get update \
    && export DEBIAN_FRONTEND="noninteractive" \
    && apt-get install -y cron \
    && rm -rf /var/lib/apt/lists/*

# Install pipx
RUN python3 -m pip install --user pipx \
    && python3 -m pipx ensurepath

# Install dosage
RUN /root/.local/bin/pipx install "dosage[css,bash] @ git+https://github.com/webcomics/dosage.git"

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

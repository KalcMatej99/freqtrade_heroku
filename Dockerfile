FROM freqtradeorg/freqtrade:stable

ENV PIP_CACHE_DIR="/home/ftuser/.cache"
ENV PYTHONUSERBASE="/home/ftuser/.local"

USER root
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install gettext-base nodejs cmake libopenmpi-dev zlib1g-dev libtinfo5

# Install dependencies:
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

COPY user_data /freqtrade/user_data
USER ftuser


WORKDIR /freqtrade

EXPOSE 5000

ENTRYPOINT ["freqtrade"]
CMD ["trade", "--logfile", "/freqtrade/user_data/logs/freqtrade.log", "--db-url", "sqlite:////freqtrade/user_data/tradesv3.sqlite", "--config", "/freqtrade/user_data/config.json", "--strategy", "MLP"]

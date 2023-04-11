FROM python:3.10-slim

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai

RUN apt update \
    && apt install -y tzdata \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN apt-get update -y && \
    apt-get install -y python3-pip procps git

RUN apt-get install -y locales locales-all fonts-noto libnss3-dev libxss1 libasound2 \
                       libxrandr2 libatk1.0-0 libgtk-3-0 libgbm-dev libxshmfence1 \
                       libdbus-1-dev libdbus-glib-1-dev

RUN pip install nb-cli hikari-bot nonebot-plugin-apscheduler && \
    pip install nonebot-plugin-gocqhttp nonebot-plugin-reboot

RUN playwright install chromium && \
    playwright install-deps

CMD ["python", "bot.py"]

FROM ubuntu:20.04

WORKDIR /root

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

ENV DEBIAN_FRONTEND noninteractive
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get clean && \
    apt-get update -y && \
    apt-get install -y python3.8 python3-pip python3.8-dev git wget

RUN git clone https://gitclone.com/github.com/CUNOE/HikariBot.git /root/HikariBot && \
    apt-get install -y locales locales-all fonts-noto libnss3-dev libxss1 libasound2 libxrandr2 libatk1.0-0 libgtk-3-0 libgbm-dev libxshmfence1 libdbus-1-dev libdbus-glib-1-dev && \
    pip install nb-cli hikari-bot nonebot-plugin-apscheduler && \
    pip install nonebot-plugin-gocqhttp nonebot-plugin-reboot && \
    playwright install firefox && \
    playwright install chromium && \
    playwright install-deps && \
    apt-get install -y 

WORKDIR /root/HikariBot
CMD ["python3", "bot.py"]

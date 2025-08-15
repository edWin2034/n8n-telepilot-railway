FROM n8nio/n8n:latest

# 1) Устанавливаем TDLib (для Alpine-образа n8n)
USER root
RUN apk add --no-cache telegram-tdlib \
 && echo "TDLib installed"

# (Опционально) создаём симлинк, если имя с версией
RUN ln -s /usr/lib/libtdjson.so /usr/lib/libtdjson.so.1 2>/dev/null || true

# 2) Ставим Telepilot как community node
USER node
RUN mkdir -p /home/node/.n8n/nodes \
 && cd /home/node/.n8n/nodes \
 && npm init -y >/dev/null 2>&1 || true \
 && npm install @telepilotco/n8n-nodes-telepilot

# 3) Путь к TDLib
ENV TELEPILOT_TDLIB_PATH=/usr/lib/libtdjson.so

# Рабочая директория по умолчанию
WORKDIR /home/node

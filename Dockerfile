FROM n8nio/n8n:latest

# 1) НЕ ставим tdlib через apk (его нет в репах Alpine)
#    Сразу переходим к установке community-нод вместе с готовой TDLib

USER node

# 2) Устанавливаем Telepilot и предсобранные бинарники TDLib от Telepilot
RUN mkdir -p /home/node/.n8n/nodes \
 && cd /home/node/.n8n/nodes \
 && npm init -y >/dev/null 2>&1 || true \
 && npm install @telepilotco/n8n-nodes-telepilot @telepilotco/tdlib-binaries-prebuilt
 && exec n8n start'

# 3) Явно укажем путь к libtdjson.so из пакета Telepilot
#    (именно к нему обращался модуль в сообщении об ошибке)
ENV TELEPILOT_TDLIB_PATH=/home/node/.n8n/nodes/node_modules/@telepilotco/tdlib-binaries-prebuilt/prebuilds/libtdjson.so

# Рабочая директория по умолчанию
WORKDIR /home/node

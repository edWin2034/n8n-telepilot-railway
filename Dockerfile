FROM n8nio/n8n:latest

# 1) Устанавливаем TDLib (Alpine)
USER root
RUN apk update \
 && apk add --no-cache tdlib \
 && (ls -l /usr/lib/libtdjson* || true) \
 && (test -e /usr/lib/libtdjson.so || ln -s /usr/lib/libtdjson.so.* /usr/lib/libtdjson.so || true)

# 2) Ставим Telepilot как community node
USER node
RUN mkdir -p /home/node/.n8n/nodes \
 && cd /home/node/.n8n/nodes \
 && npm init -y >/dev/null 2>&1 || true \
 && npm install @telepilotco/n8n-nodes-telepilot

# 3) Явный путь к TDLib (на всякий случай)
ENV TELEPILOT_TDLIB_PATH=/usr/lib/libtdjson.so

WORKDIR /home/node

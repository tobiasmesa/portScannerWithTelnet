
#!/usr/bin/env bash
SERVER=google.com
PORT=(80, 60, 70)

for $i in "${PORTS[@]}" do
</dev/tcp/$SERVER/$PORT # TCP O UDP
if [ "$?" -ne 0 ]; then
  echo "Connection to $SERVER on port $PORT failed"
  exit 1
else
  echo "Connection to $SERVER on port $PORT succeeded"
  exit 0
fi
done
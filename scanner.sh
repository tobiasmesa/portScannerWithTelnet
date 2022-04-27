
#!/usr/bin/env bash
SERVER=google.com
PORT=(80 60 70)

for i in "${PORT[@]}" 
do
</dev/tcp/$SERVER/$PORT 
if [ "$?" -ne 0 ]; then
  echo "Connection to $SERVER on port $PORT failed"
  
else
  echo "Connection to $SERVER on port $PORT succeeded"
  
fi
done
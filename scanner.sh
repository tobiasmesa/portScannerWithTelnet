
#!/usr/bin/env bash
SERVER=google.com
PORT=(80 60 70)

for i in "${PORT[@]}" 
do
</dev/tcp/$SERVER/$i 
if [ "$?" -ne 0 ]; then
  echo "Connection to $SERVER on port $i failed"
  
else
  echo "Connection to $SERVER on port $i succeeded"
  
fi
done
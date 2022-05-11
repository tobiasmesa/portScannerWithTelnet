 if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 <host> <port, ports, or port-range>"
    exit
  fi

  host=$1
  ports=()
  case $2 in
    *-*)
      IFS=- read start end <<< "$2"
      for ((port=start; port <= end; port++)); do
        ports+=($port)
      done
      ;;
    *,*)
      IFS=, read -ra ports <<< "$2"
      ;;
    *)
      ports+=($2)
      ;;
  esac

  for port in "${ports[@]}"; do
    timeout 2 bash -c "echo >/dev/tcp/$host/$port" &&
      echo "Port TCP $port, open
      " ||
      echo "Port TCP $port, closed
      "
  done

  for port in "${ports[@]}"; do
    timeout 2 bash -c "echo >/dev/udp/$host/$port" &&
      echo "Port UDP $port, open
      " ||
      echo "Port UDP $port, closed
      "
  done
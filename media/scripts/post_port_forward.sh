#!/bin/sh
set -eu

LOGFILE=/tmp/gluetun_pf.log
PORT_FILE=/tmp/gluetun/forwarded_port
RPC="http://127.0.0.1:9091/transmission/rpc"

log() {
  echo "$(date) $*" >> "$LOGFILE"
  echo "$*"
}

[ -f "$PORT_FILE" ] || { log "[post_port_forward] ERROR: no existe $PORT_FILE"; exit 1; }

PORT="$(tr -d '\r\n[:space:]' < "$PORT_FILE")"
[ -n "$PORT" ] || { log "[post_port_forward] ERROR: puerto vacío"; exit 1; }

log "[post_port_forward] forwarded_port=$PORT"

iptables -C INPUT -p tcp --dport "$PORT" -j ACCEPT 2>/dev/null || iptables -I INPUT -p tcp --dport "$PORT" -j ACCEPT
iptables -C INPUT -p udp --dport "$PORT" -j ACCEPT 2>/dev/null || iptables -I INPUT -p udp --dport "$PORT" -j ACCEPT
log "[post_port_forward] iptables opened for TCP/UDP $PORT"

SID=""
for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20; do
  SID="$(
    wget -S -O /dev/null "$RPC" 2>&1 \
      | tr -d '\r' \
      | sed -n 's/^  X-Transmission-Session-Id: //p' \
      | tail -n 1
  )" || true

  if [ -n "$SID" ]; then
    break
  fi

  log "[post_port_forward] esperando a Transmission... intento $i"
  sleep 100
done

[ -n "$SID" ] || { log "[post_port_forward] ERROR: no se pudo obtener Transmission Session-Id"; exit 1; }

JSON="{\"method\":\"session-set\",\"arguments\":{\"peer-port\":$PORT,\"peer-port-random-on-start\":false}}"

wget -qO- \
  --header="X-Transmission-Session-Id: $SID" \
  --header="Content-Type: application/json" \
  --post-data="$JSON" \
  "$RPC" >/dev/null

log "[post_port_forward] puerto peer de Transmission actualizado a $PORT"

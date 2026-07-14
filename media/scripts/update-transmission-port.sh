#!/bin/sh
set -eu

PORT_FILE="/tmp/gluetun/forwarded_port"
[ -f "$PORT_FILE" ] || exit 0
PORT="$(cat "$PORT_FILE")"

TR_USER="${TR_USER:-}"
TR_PASS="${TR_PASS:-}"

RPC="http://cali-home:9091/transmission/rpc"

SID="$(curl -sI ${TR_USER:+-u "$TR_USER:$TR_PASS"} "$RPC" \
  | awk -F': ' 'tolower($1)=="x-transmission-session-id"{print $2}' | tr -d '\r')"

# Set peer-port
curl -s ${TR_USER:+-u "$TR_USER:$TR_PASS"} \
  -H "X-Transmission-Session-Id: $SID" \
  -H "Content-Type: application/json" \
  --data "{\"method\":\"session-set\",\"arguments\":{\"peer-port\":$PORT}}" \
  "$RPC" >/dev/null

echo "Puerto peer de Transmission actualizado a $PORT"

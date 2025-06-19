echo "╔═════════════════════════════════════╗"
echo "║ ▖    ▌ ▌   ▘    ▖       ▄▖          ║"
echo "║ ▌▀▌▛▘▙▘▛▌▛▌▌▛▘  ▌ ▀▌▛▌  ▚ █▌▛▘▌▌█▌▛▘║"
echo "║▙▌█▌▙▖▛▖▙▌▙▌▌▄▌  ▙▖█▌▌▌  ▄▌▙▖▌ ▚▘▙▖▌ ║"
echo "╚═════════════════════════════════════╝"

# ➢ arrowhead

echo "\n➢ Starting Tailscale ..." 

docker compose up -d tailscale 

echo "\n➢ Waiting for Tailscale to report an IP ..."

MAX_ATTEMPTS=30
attempt=1

while true; do
    TS_IP=$(docker exec tailscale tailscale ip -4 2>/dev/null | grep '^100\.' | head -n1)

    if [ -n "$TS_IP" ]; then
        echo "[INFO] Tailscale IP: $TS_IP"
        break
    fi

    if [ "$attempt" -ge "$MAX_ATTEMPTS" ]; then
        echo "[ERROR] Tailscale did not report an IP after $MAX_ATTEMPTS seconds."
        exit 1
    fi

    attempt=$((attempt+1))
    sleep 1
done

echo "\n➢ Starting applications ..."

docker compose up --build -d

echo "\n➢ Success!"
exit 0
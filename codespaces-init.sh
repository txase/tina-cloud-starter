#!/bin/bash

# Replace localhost with GitHub Codespaces port forwarding URL in admin site
(
    while [ ! -f public/admin/index.html ]; do
        inotifywait -e create public/admin
    done

    while
        sed -e "s/http:\/\/localhost:4001/https:\/\/${CODESPACE_NAME}-4001.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/" public/admin/index.html > /tmp/index.html
        mv /tmp/index.html public/admin/index.html
        inotifywait -e close_write public/admin/index.html
    do true; done
) &

# Install npm dependencies
echo "Running 'npm install'..."
npm install

# Ports to forward
PORTS=(3000 4001 9000)

# Wait for ports to be forwarded, then make them public
while (( ${#PORTS[@]} > 0 )); do
    echo "Waiting for ports ${PORTS[@]}"
    FORWARDED=`gh codespace ports -c $CODESPACE_NAME --json sourcePort`
    REMAINING_PORTS=()
    for PORT in "${PORTS[@]}"; do
        if echo $FORWARDED | grep $PORT >/dev/null; then
            echo "Forwarding port $PORT publicly"
            gh codespace ports -c $CODESPACE_NAME visibility ${PORT}:public
        else
            REMAINING_PORTS+=($PORT)
        fi
    done
    PORTS=("${REMAINING_PORTS[@]}")
    sleep 1;
done &

# Start Tina CMS dev server
echo "Starting Tina CMS dev server..."
npm run dev
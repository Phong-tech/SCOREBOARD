#!/bin/bash

USER_FILE="/home/phong/idg1100-exam-main/login.txt"

# Read POST data
read POST_DATA
USERNAME=$(echo "$POST_DATA" | sed -n 's/.*username=\([^&]*\).*/\1/p')
PASSWORD=$(echo "$POST_DATA" | sed -n 's/.*password=\([^&]*\).*/\1/p')

# Check if credentials match
USER_DATA=$(grep "^$USERNAME:$PASSWORD" "$USER_FILE")
if [[ -n "$USER_DATA" ]]; then
    echo "Content-type: text/html"
    echo ""
    echo "<html><head><meta http-equiv='refresh' content='0;url=game.html'></head></html>"
    echo "$USERNAME" > /tmp/current_user.txt
else
    echo "Content-type: text/html"
    echo ""
    echo "<h1>Login Failed!</h1>"
    echo "<a href='/index.html'>Try again</a>"
fi

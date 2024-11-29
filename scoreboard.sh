#!/bin/bash

SCOREBOARD_FILE="/tmp/scoreboard.txt"

echo "Content-type: text/html"
echo ""

if [ "$REQUEST_METHOD" == "POST" ]; then
    read POST_DATA
    USERNAME=$(echo "$POST_DATA" | sed -n 's/^.*username=\([^&]*\).*$/\1/p')
    RESULT=$(echo "$POST_DATA" | sed -n 's/^.*result=\([^&]*\).*$/\1/p')

    awk -F: -v user="$USERNAME" -v result="$RESULT" '
    BEGIN {updated = 0}
    {
        if ($1 == user) {
            $2++; result == "WIN" ? $3++ : $4++;
            updated = 1;
        }
        print $0
    }
    END {
        if (!updated) {
            print user ":1:" (result == "WIN" ? "1:0" : "0:1")
        }
    }' "$SCOREBOARD_FILE" > "${SCOREBOARD_FILE}.tmp" && mv "${SCOREBOARD_FILE}.tmp" "$SCOREBOARD_FILE"
    exit
fi

cat <<EOM
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scoreboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Scoreboard</h1>
    <table border="1" cellpadding="10" cellspacing="0" style="margin: auto; text-align: center;">
        <tr>
            <th>Username</th>
            <th>Games Played</th>
            <th>Wins</th>
            <th>Losses</th>
        </tr>
EOM

awk -F: '{printf "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>\n", $1, $2, $3, $4}' "$SCOREBOARD_FILE"

cat <<EOM
    </table>
    <form action="./index.html" method="GET">
        <button type="submit">Back to Game</button>
    </form>
</body>
</html>
EOM

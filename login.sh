#!/bin/bash

echo "Content-type: text/html"
echo ""

# Parse username
read POST_DATA
USERNAME=$(echo "$POST_DATA" | sed -n 's/^.*username=\([^&]*\).*$/\1/p' | sed 's/%20/ /g')

# Save username in a temporary file
echo "$USERNAME" > /tmp/current_user.txt

# Redirect to the game page
cat <<EOM
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Successful</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Welcome, $USERNAME!</h1>
    <form action="./test.sh" method="post">
        <input type="number" name="guess" min="-99" max="99" step="1" placeholder="Enter your guess" required>
        <input type="submit" value="Submit guess">
    </form>
</body>
</html>
EOM

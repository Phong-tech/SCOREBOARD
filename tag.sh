#!/bin/bash

USER_FILE="/home/phong/idg1100-exam-main/login.txt"

# Register or log in a user
function handle_user() {
    # Read POST data (when called from the form)
    read POST_DATA
    gamertag=$(echo "$POST_DATA" | sed -n 's/.*gamertag=\([^&]*\).*/\1/p' | sed 's/+/ /g' | tr -d '\r')

    echo

    # Check if the gamer tag exists in the user file using grep
    if grep -q "^$gamertag$" "$USER_FILE"; then
        echo "Welcome back, $gamertag! You are now logged in."
    else
        # Add the new gamer tag to the file
        if echo "$gamertag" >> "$USER_FILE"; then
            echo "Registration successful! Welcome, $gamertag!"
        else
            echo "Error: Could not write to $USER_FILE" >&2
            exit 1
        fi
    fi

    # Save the logged-in user to the session file
    if echo "$gamertag" > /home/phong/idg1100-exam-main/current_user.txt; then
        echo "Successfully logged $gamertag to current_user.txt"
    else
        echo "Error: Unable to write to current_user.txt. Check permissions." >&2
        exit 1
    fi
}

# Output HTTP headers
echo "Content-type: text/html"
echo ""

# Call the handle_user function
handle_user

# HTML Response
cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Gamer Tag Submission</title>
</head>
<body>
    <h1>Submission Successful</h1>
    <p>Thank you, your gamer tag has been recorded.</p>
    <a href="./index.html">Go Back</a>
</body>
</html>
EOF


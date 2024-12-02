#!/bin/bash

USER_FILE="/home/phong/idg1100-exam-main/login.txt"

# Register or log in a user
function handle_user() {
    read -p "Enter your gamer tag: " gamertag
    echo
    # Use `awk` to check if the gamer tag exists
    if awk -F: -v user="$gamertag" '$1 == user {exit 0} END {exit 1}' "$USER_FILE"; then
        echo "Welcome back, $gamertag! You are now logged in."
    else
        # Add the new gamer tag to the file
        echo "$gamertag" >> "$USER_FILE"
        echo "Registration successful! Welcome, $gamertag!"
    fi
    # Save the logged-in user to a temporary file
    echo "$gamertag" > /tmp/current_user.txt
}

# Main function
echo "1. Enter Gamer Tag to Play"
read -p "Select an option: " option
if [[ "$option" == "1" ]]; then
    handle_user
else
    echo "Invalid option."
fi

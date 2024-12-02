function handle_user() {
    read -p "Enter your gamer tag: " gamertag
    echo
    if awk -F: -v user="$gamertag" '$1 == user {exit 0} END {exit 1}' "$USER_FILE"; then
        echo "Welcome back, $gamertag! You are now logged in."
    else
        echo "$gamertag" >> "$USER_FILE" || {
            echo "Error: Could not write to $USER_FILE" >&2
            exit 1
        }
        echo "Registration successful! Welcome, $gamertag!"
    fi

    # Save the logged-in user to the session file
    if echo "$gamertag" > /home/phong/idg1100-exam-main/current_user.txt; then
        echo "Successfully logged $gamertag to current_user.txt"
    else
        echo "Error: Unable to write to current_user.txt. Check permissions." >&2
        exit 1
    fi
}

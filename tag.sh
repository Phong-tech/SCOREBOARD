function handle_user() {
    read -p "Enter your gamer tag: " gamertag
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

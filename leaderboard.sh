#!/bin/bash

LEADERBOARD_FILE="/path/to/leaderboard.txt"

# Update leaderboard with a new result
function update_leaderboard() {
    user=$1
    diff=$2

    if grep -q "^$user:" "$LEADERBOARD_FILE"; then
        old_data=$(grep "^$user:" "$LEADERBOARD_FILE")
        plays=$(echo "$old_data" | cut -d':' -f2)
        total_diff=$(echo "$old_data" | cut -d':' -f3)

        plays=$((plays + 1))
        total_diff=$((total_diff + diff))
        avg_diff=$((total_diff / plays))

        sed -i "" "/^$user:/d" "$LEADERBOARD_FILE"
        echo "$user:$plays:$total_diff:$avg_diff" >> "$LEADERBOARD_FILE"
    else
        echo "$user:1:$diff:$diff" >> "$LEADERBOARD_FILE"
    fi
}

# Display the leaderboard
function show_leaderboard() {
    echo "Leaderboard:"
    echo "User       | Games Played | Average Diff"
    echo "---------------------------------------"
    sort -t':' -k4 -n "$LEADERBOARD_FILE" | while IFS=: read -r user plays total avg; do
        printf "%-10s | %-12s | %-12s\n" "$user" "$plays" "$avg"
    done
}

# Main function
if [[ "$1" == "update" ]]; then
    update_leaderboard "$2" "$3"
else
    show_leaderboard
fi

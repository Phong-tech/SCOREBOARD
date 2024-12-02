# Register a new user
function register_user() {
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo
    if grep -q "^$username:" "$USER_FILE"; then
        echo "Username already exists. Please log in."
        return 1
    fi
    echo "$username:$password" >> "$USER_FILE"
    echo "Registration successful!"
}

# Log in an existing user
function login_user() {
    read -p "Enter username: " username
    read -sp "Enter password: " password
    echo
    if grep -q "^$username:$password" "$USER_FILE"; then
        echo "Login successful!"
        echo "$username" > /tmp/current_user.txt
        return 0
    else
        echo "Invalid credentials."
        return 1
    fi
}

# Main function
echo "1. Register"
echo "2. Login"
read -p "Select an option: " option
if [[ "$option" == "1" ]]; then
    while ! register_user; do :; done
elif [[ "$option" == "2" ]]; then
    while ! login_user; do :; done
else
    echo "Invalid option."
fi

can you implement this in this 

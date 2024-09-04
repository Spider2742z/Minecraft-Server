#!/bin/bash

#BBI Sun Ye Github mai work nahi karta kyuki github screen allow nahi karta tu ek bar try kar liyo
# Define the path to the Minecraft server and Git repository
SERVER_START_COMMAND="./start_server.sh"  # Replace with your server start command
SESSION_NAME="minecraft_server"

# Check if a screen session with the name exists
if screen -list | grep -q "$SESSION_NAME"; then
    echo "A screen session named '$SESSION_NAME' is already running."
        echo "Stopping it before starting a new one."
            screen -S "$SESSION_NAME" -X quit
            fi

            # Start a new screen session and run the Minecraft server
            echo "Starting Minecraft server in a new screen session..."
            screen -dmS "$SESSION_NAME" bash -c "$SERVER_START_COMMAND"

            # Inform the user and wait for the server to stop
            echo "Minecraft server is running in the screen session '$SESSION_NAME'."
            echo "To attach to the screen session, use: screen -r $SESSION_NAME"
            echo "To stop the server and perform Git operations, use: screen -S $SESSION_NAME -X quit"

            # Wait for the screen session to end
            screen -r "$SESSION_NAME" -X quit  # Ensure session ends

            # Perform Git operations
            echo "Committing changes to Git..."
            git add .

            # Commit changes with date and time as the message
            COMMIT_MESSAGE="Update on $(date '+%Y-%m-%d %H:%M:%S')"
            git commit -m "$COMMIT_MESSAGE"

            # Push changes to the repository
            git push

            echo "Git operations completed."

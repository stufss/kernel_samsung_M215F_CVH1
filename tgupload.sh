#!/bin/bash

source local.config

# File to upload
FILE="$1"

# Function to upload a file to Telegram
function tg_sendFile() {
    curl -s "https://api.telegram.org/bot$BOT_TOKEN/sendDocument" \
        -F "chat_id=$CHAT_ID" \
        -F "document=@$FILE"
}

# Call the function to upload the file
tg_sendFile
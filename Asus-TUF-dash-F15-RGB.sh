#!/bin/bash

# Define the path to the brightness file
brightness_file="/sys/class/leds/asus::kbd_backlight/brightness"

# Display the initial prompt
echo "Enter a number for brightness (1 to 3) or type 'exit' to quit:"

while true; do
    # Read the user input without displaying the prompt each time
    read -p "" input

    # Check if the user wants to exit
    if [ "$input" == "exit" ]; then
        echo "Exiting..."
        break
    fi

    # Validate the input
    if [[ "$input" =~ ^[1-3]$ ]]; then
        # Check if the file is writable
        if [ -w "$brightness_file" ]; then
            echo "$input" | sudo tee "$brightness_file" > /dev/null
            echo "Brightness set to $input"
        else
            echo "Cannot write to $brightness_file. Check permissions."
        fi
    else
        echo "Invalid input: Please enter a number between 1 and 3."
    fi
done


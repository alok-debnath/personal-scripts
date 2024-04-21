#!/bin/bash

# Function to display a Fish logo
# display_fish_logo() {
#     echo "       ____"
# }

# Display Fish logo and header
echo "><> ><> ><> ><> ><> ><> ><> ><> ><>"
echo "  F i s h   S h e l l   S e t u p"
echo "><> ><> ><> ><> ><> ><> ><> ><> ><>"
echo
# display_fish_logo
# echo

# Path to your custom Fish config file (relative to the script)
custom_config_file="./scripts/configs/custom-config.fish"

# Path to the actual Fish config folder
fish_config_folder="$HOME/.config/fish"

# Resolve the absolute path of custom_config_file
custom_config_file=$(realpath "$custom_config_file")

# Check if the custom config file exists
if [ -f "$custom_config_file" ]; then
    # Check if symlink already exists
    if [ -h "$fish_config_folder/custom-config.fish" ]; then
        # Override the existing symlink
        ln -sf "$custom_config_file" "$fish_config_folder/custom-config.fish"
        echo "Symlink overridden successfully!"
    else
        # Create a new symlink
        ln -s "$custom_config_file" "$fish_config_folder/custom-config.fish"
        echo "Symlink created successfully!"
    fi

    # Add source line to the actual config file
    echo "# Adding source line to the actual config file..."

    # Add source line to the actual config file
    if ! grep -q "source $custom_config_file" "$fish_config_folder/config.fish"; then
        # Add source line to the actual config file itself
        echo "source $custom_config_file" >>"$fish_config_folder/config.fish"
        echo "Source line added to the actual config file."
    else
        echo "Source line for the custom config already exists."
    fi
else
    echo "Custom Fish config file not found."
fi

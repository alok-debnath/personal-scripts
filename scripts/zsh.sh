#!/bin/bash

# Display Zsh logo and header
echo "zzz zzz zzz zzz zzz zzz zzz zzz zzz"
echo "   Z S H   S h e l l   S e t u p"
echo "zzz zzz zzz zzz zzz zzz zzz zzz zzz"
echo

# Path to your custom Zsh config file (relative to the script)
custom_config_file="./scripts/configs/custom-zsh-config.zsh"

# Path to the Zshrc file
zshrc_file="$HOME/.zshrc"

# Resolve the absolute path of custom_config_file
custom_config_file=$(realpath "$custom_config_file")

# Check if the custom config file exists
if [ -f "$custom_config_file" ]; then
    # Check if .zshrc file exists
    if [ -f "$zshrc_file" ]; then
        # Check if source line already exists in .zshrc
        if grep -q "# sourcing custom user zsh config" "$zshrc_file"; then
            # Remove existing source line and comment
            sed -i '/# sourcing custom user zsh config/,+1d' "$zshrc_file"
            echo "Existing source line and comment removed."
        fi

        # Add source line to the .zshrc file on a new line
        echo -e "\n# sourcing custom user zsh config" >>"$zshrc_file"
        echo "source $custom_config_file" >>"$zshrc_file"
        echo "Source line added to the .zshrc file."
    else
        echo ".zshrc file not found. Please make sure it exists in your home directory."
    fi
else
    echo "Custom Zsh config file not found."
fi

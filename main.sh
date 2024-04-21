#!/bin/bash

# Function to execute a script
execute_script() {
    script_name=$1
    script_path="./scripts/$script_name"
    if [ -f "$script_path" ]; then
        chmod +x "$script_path"
        "$script_path"
    else
        echo "Script '$script_name' not found."
    fi
}

# List of scripts to execute
scripts=(
    # "fish.sh"
    "removeFromKeybinds.sh"
    # Add more script names here if needed
)

# Execute each script one by one
for script in "${scripts[@]}"; do
    read -p "Do you want to execute the script '$script'? (y/N): " execute_script_choice
    execute_script_choice=${execute_script_choice,,} # Convert to lowercase
    if [ "$execute_script_choice" == "y" ]; then
        echo -e "Executing script: $script"
        echo
        execute_script "$script"
        echo
        echo "-----------------------------------"
        echo
    else
        echo "Skipping script: $script"
        echo "-----------------------------------"
    fi
done

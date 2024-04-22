#!/bin/bash

RESET='\033[0m' # Text Reset

# Regular Colors
BLACK='\033[0;30m'  # Black
RED='\033[0;31m'    # Red
GREEN='\033[0;32m'  # Green
YELLOW='\033[0;33m' # Yellow
BLUE='\033[0;34m'   # Blue
PURPLE='\033[0;35m' # Purple
CYAN='\033[0;36m'   # Cyan
WHITE='\033[0;37m'  # White

# Bold
BOLD_BLACK='\033[1;30m'  # Black
BOLD_RED='\033[1;31m'    # Red
BOLD_GREEN='\033[1;32m'  # Green
BOLD_YELLOW='\033[1;33m' # Yellow
BOLD_BLUE='\033[1;34m'   # Blue
BOLD_PURPLE='\033[1;35m' # Purple
BOLD_CYAN='\033[1;36m'   # Cyan
BOLD_WHITE='\033[1;37m'  # White

# Underline
UNDERLINE_BLACK='\033[4;30m'  # Black
UNDERLINE_RED='\033[4;31m'    # Red
UNDERLINE_GREEN='\033[4;32m'  # Green
UNDERLINE_YELLOW='\033[4;33m' # Yellow
UNDERLINE_BLUE='\033[4;34m'   # Blue
UNDERLINE_PURPLE='\033[4;35m' # Purple
UNDERLINE_CYAN='\033[4;36m'   # Cyan
UNDERLINE_WHITE='\033[4;37m'  # White

# Background
BG_BLACK='\033[40m'  # Black
BG_RED='\033[41m'    # Red
BG_GREEN='\033[42m'  # Green
BG_YELLOW='\033[43m' # Yellow
BG_BLUE='\033[44m'   # Blue
BG_PURPLE='\033[45m' # Purple
BG_CYAN='\033[46m'   # Cyan
BG_WHITE='\033[47m'  # White

# High Intensity
HI_BLACK='\033[0;90m'  # Black
HI_RED='\033[0;91m'    # Red
HI_GREEN='\033[0;92m'  # Green
HI_YELLOW='\033[0;93m' # Yellow
HI_BLUE='\033[0;94m'   # Blue
HI_PURPLE='\033[0;95m' # Purple
HI_CYAN='\033[0;96m'   # Cyan
HI_WHITE='\033[0;97m'  # White

# Bold High Intensity
BOLD_HI_BLACK='\033[1;90m'  # Black
BOLD_HI_RED='\033[1;91m'    # Red
BOLD_HI_GREEN='\033[1;92m'  # Green
BOLD_HI_YELLOW='\033[1;93m' # Yellow
BOLD_HI_BLUE='\033[1;94m'   # Blue
BOLD_HI_PURPLE='\033[1;95m' # Purple
BOLD_HI_CYAN='\033[1;96m'   # Cyan
BOLD_HI_WHITE='\033[1;97m'  # White

# High Intensity backgrounds
BG_HI_BLACK='\033[0;100m'  # Black
BG_HI_RED='\033[0;101m'    # Red
BG_HI_GREEN='\033[0;102m'  # Green
BG_HI_YELLOW='\033[0;103m' # Yellow
BG_HI_BLUE='\033[0;104m'   # Blue
BG_HI_PURPLE='\033[0;105m' # Purple
BG_HI_CYAN='\033[0;106m'   # Cyan
BG_HI_WHITE='\033[0;107m'  # White

DIVIDER="${BOLD_RED}-----------------------------------${RESET}"

# Function to display script information
display_script_info() {
    script_name=$1
    info_file="./scripts/${script_name%.*}.info"
    if [ -f "$info_file" ]; then
        cat "$info_file"
    else
        echo "No information available for script: $script_name"
    fi
}

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

# Associative array to store script names and their information
declare -A scripts=(
    ["removeFromKeybinds.sh"]="Remove From Keybinds: This script removes unwanted keybindings from hyprdots keybindings."
    ["zsh.sh"]="ZSH Configuration: This script adds extra user defined aliases and other things to the ZSH config."
    # Add more script names and info here if needed
)

# Execute each script one by one
for script in "${!scripts[@]}"; do
    echo -n "Do you want to execute the script "
    echo -e "'${GREEN}$script${RESET}' ? (y/N/i): "
    read -r execute_script_choice
    execute_script_choice=${execute_script_choice,,} # Convert to lowercase
    case $execute_script_choice in
    y)
        echo -e "Executing script: ${GREEN}$script${RESET}"
        echo
        execute_script "$script"
        echo
        echo -e "${DIVIDER}"
        ;;
    n | "")
        echo "Skipping script: $script"
        echo -e "${DIVIDER}"
        ;;
    i)
        echo "Information about the script: $script"
        echo "${scripts[$script]}"
        echo -e "${DIVIDER}"
        echo -n "Execute the script? (y/N): "
        read -r proceed_choice
        proceed_choice=${proceed_choice,,} # Convert to lowercase
        case $proceed_choice in
        y)
            echo -e "Executing script: ${GREEN}$script${RESET}"
            echo
            execute_script "$script"
            echo
            echo -e "${DIVIDER}"
            ;;
        *)
            echo "Skipping script: $script"
            echo -e "${DIVIDER}"
            ;;
        esac
        ;;
    *)
        echo "Invalid choice. Skipping script: $script"
        echo -e "${DIVIDER}"
        ;;
    esac
done

#!/bin/bash

# Display Fish logo and header
echo "*** *** *** *** *** *** *** *** *** ***"
echo "  C L E A N I N G    K E Y B I N D S"
echo "*** *** *** *** *** *** *** *** *** ***"
echo

# Define the file path
file="$HOME/.config/hypr/hyprland/keybinds.conf"

# replacement
# "#" === comment
# "" === delete line
# "replacement text" === replace

# Define an associative array to store text-to-replace and their replacements
declare -A replacements=(
    ["bind = Super, W, exec, firefox"]=""
    ["bind = Control+Super, W, exec, thorium-browser --ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation"]=""
    ["bind = Super, B, exec, ags -t 'sideleft'"]=""
    ["bind = Control+Super+Alt, E, exec, /usr/bin/microsoft-edge-stable --password-store=gnome --ozone-platform-hint=wayland --gtk-version=4 --ignore-gpu-blocklist --enable-features=TouchpadOverscrollHistoryNavigation"]=""
    ["bind = Super+Shift, W, exec, wps"]=""
    ["bind = Super, C, exec, code --password-store=gnome --enable-features=UseOzonePlatform --ozone-platform=wayland"]=""
    # ["text_to_replace"]="replacement"
)

# Initialize counter
count=0

# Loop through the associative array and perform replacements
for text_to_replace in "${!replacements[@]}"; do
    replacement="${replacements[$text_to_replace]}"
    # Escape special characters in the text to be replaced
    escaped_text_to_replace=$(printf '%s\n' "$text_to_replace" | sed 's/[\&/]/\\&/g')
    # If replacement is '#', add '#' before the line
    if [ "$replacement" = "#" ]; then
        sed -i "/$escaped_text_to_replace/s/^/#/" "$file"
    # If replacement is '', remove the line
    elif [ "$replacement" = "" ]; then
        sed -i "/$escaped_text_to_replace/d" "$file"
    # Otherwise, perform the replacement
    else
        sed -i "s/$escaped_text_to_replace/$replacement/" "$file"
    fi
    # Increment counter
    ((count++))
done

echo "Replacement completed. Total lines modified: $count"

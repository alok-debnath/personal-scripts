#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[1;34m'
RESET='\033[0m'

echo -e "${BLUE}=== Setting up WSL Windsurf Launcher ===${RESET}"

# Create required directories
mkdir -p ~/.local/bin

# Find the windsurf executable
WINDSURF_CMD=$(command -v windsurf 2>/dev/null)
if [ -z "$WINDSURF_CMD" ]; then
    echo "ERROR: windsurf command not found in PATH" >&2
    exit 1
fi

# Create the main launcher script
cat > ~/.local/bin/wf << 'EOF'
#!/bin/bash

# Find windsurf executable
WINDSURF_CMD=$(command -v windsurf 2>/dev/null)
if [ -z "$WINDSURF_CMD" ]; then
    echo "ERROR: windsurf command not found in PATH" >&2
    exit 1
fi

# If no argument, use current directory
if [ -z "$1" ]; then
    TARGET_PATH=$(pwd)
    URI_SCHEME="folder-uri"
else
    TARGET_PATH=$(readlink -f "$1" 2>/dev/null || echo "$1")
    
    # Check if path exists
    if [ ! -e "$TARGET_PATH" ]; then
        echo "ERROR: Path does not exist: $TARGET_PATH" >&2
        exit 1
    fi
    
    # Determine if it's a file or directory
    if [ -f "$TARGET_PATH" ]; then
        URI_SCHEME="file-uri"
    elif [ -d "$TARGET_PATH" ]; then
        URI_SCHEME="folder-uri"
    else
        echo "ERROR: Unsupported file type: $TARGET_PATH" >&2
        exit 1
    fi
fi

# Convert WSL path to Windows path if needed
# if [[ "$TARGET_PATH" == /mnt/* ]]; then
#     # Convert /mnt/c/... to C:/...
#     WIN_PATH=$(echo "$TARGET_PATH" | sed 's|/mnt/\([a-zA-Z]\)|\U\1:|' | tr '/' '\\')
#     URI="file://$WIN_PATH"
# else
    # For WSL paths, use vscode-remote
    ENCODED_PATH=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$TARGET_PATH")
    URI="vscode-remote://wsl+Ubuntu$ENCODED_PATH"
# fi

# Launch Windsurf
"$WINDSURF_CMD" "--$URI_SCHEME" "$URI"
EOF

# Make the launcher executable
chmod +x ~/.local/bin/wf

# Add to .zshrc if not already present
if ! grep -Fq 'export PATH="$HOME/.local/bin:$PATH"' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# ====== Windsurf Launcher Config ======
# Add local bin to PATH if not already present
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
# ====== End of Windsurf Launcher Config ======
EOF
    echo -e "${GREEN}✓ Added Windsurf launcher to PATH in ~/.zshrc${RESET}"
else
    echo "Windsurf launcher configuration already exists in ~/.zshrc"
fi

echo -e "${GREEN}✓ WSL Windsurf launcher setup complete!${RESET}"
echo -e "You can now use 'wf' command to open files and folders in Windsurf from WSL"
echo -e "Example: wf /path/to/file_or_folder"
echo -e "Open a new terminal or run: source ~/.zshrc"

exit 0

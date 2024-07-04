#!/bin/bash

source .env/vars.sh
source "$HOME/.devenv/common/sources.sh" #temp

# Define the help function
help() {
    echo "Usage: ./setup.sh [command]"
    echo
    echo "Commands:"
    echo "  initialize     Run the initialize function"
    echo "  update         Run the update function"
    echo "  help           Display this help message"
    echo
    echo "If no command is provided, 'initialize' will be run by default."
}

# Define the initialize function
initialize() {
    echo "Running initialize function..."
}

# Define the update function
update() {
    echo "Running update function..."
}

make_symlinks() {
    echo "Creating symlinks..."
}

install_neovim() {
    sudo apt install neovim
    mkdir -p ~/.config/nvim
    touch ~/.config/nvim/init.vim
}

install_tmux() {
    sudo apt install tmux
}

install_all() {
    install_neovim
    install_tmux
}

install_vscode_ext() {
    echo "Installing vscode ext..."
    local dest="$PATH_DEVAPPS/.vscode/extensions"
    local filename_with_ext="vscode-extensions.txt"
    local filename="$dest/$filename_with_ext"

    if [ -f "$filename" ]; then
        cat "$filename" | xargs -L 1 code --install-extension
        if [ $? -eq 0 ]; then
            echo "VSCode Extensions from '$filename' successfully installed."
            return 0
        else
            echo "Error: Failed to install VSCode Extensions."
            return 1
        fi
    else
        echo "'$filename' not found."
    fi
}

backup_vscode_ext() {
    # fix error in suffix
    local dest="$PATH_DEVAPPS/.vscode/extensions/.backup"
    local filename_with_ext="extensions-list.txt"
    local suffix="_$(get_datetime --backup)"

    local filename="${filename_with_ext%.*}"
    local extension="${filename_with_ext##*.}"

    filename="${filename}${suffix}.${extension}"

    create_directories "$dest"
    code --list-extensions > "$dest/$filename"
    if [ $? -eq 0 ]; then
        echo "VSCode Extensions list backup file:'$dest/$filename'"
        return 0
    else
        echo "Error: Failed to backup VSCode Extensions."
        return 1
    fi
}

# Check the parameter and call the corresponding function
if [ -z "$1" ]; then
    # No parameter passed, default to initialize
    initialize
else
    # Parameter passed, execute the corresponding function
    case "$1" in
		help)
			help
			;;
        init)
            initialize
            ;;
        "make:symlinks")
            make_symlinks
            ;;
        "install:all")
            install_all
            ;;
        "install:tmux")
            install_tmux
            ;;
        "install:vscode.ext")
            install_vscode_ext
            ;;
        "backup:vscode.ext")
            backup_vscode_ext
            ;;
        update)
            update
            ;;
        *)
            echo "Invalid parameter. Usage: ./setup.sh [init|update|"make:symlinks"]"
            exit 1
            ;;
    esac
fi
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
        update)
            update
            ;;
        *)
            echo "Invalid parameter. Usage: ./setup.sh [init|update|"make:symlinks"]"
            exit 1
            ;;
    esac
fi
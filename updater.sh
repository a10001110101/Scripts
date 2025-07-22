#!/bin/bash
#Created        7/13/2025
#Modified       7/21/2025

function display_menu {
    echo "----------------------------------------"
    echo "Welcome to the HAL9000 Management System"
    echo "----------------------------------------"
    echo "1. Update the OS"
    echo "2. Update WebUI"
    echo "3. Autoremove packages"
    echo "6. Get all installed packages"
    echo "7. Find an installed package"
    echo "8. Restart"
    echo "9. Exit"
    echo "----------------------------------------"
}

while true; do
    display_menu
    read -p "Please select a choice from above: " choice

    case $choice in
        1)
            echo "Updating the OS..."
            sudo apt update && sudo apt full-upgrade -y
            read -p "Press Enter to continue or 'q' to quit: " input
            echo
            if [[ "${input,,}" == "q" ]]; then
                echo "Exiting.  Goodbye!"
                exit 0
            fi
            ;;
        2)
            echo "Running webui-updater.sh script..."
            sudo sh ./webui-updater.sh
            ;;
        3)
            echo "Autoremoving packages..."
            sudo apt autoremove
            read -p "Press Enter to continue or 'q' to quit: " input
            echo
            if [[ "${input,,}" == "q" ]]; then
                echo "Exiting.  Goodbye!"
                exit 0
            fi
            ;;
        6)
            echo "Getting a list of all installed packages..."
            apt list --installed >> installed.txt
            echo "List has been generated.  Please look at installed.txt."
            read -p "Press Enter to continue or 'q' to quit: " input
            echo
            if [[ "${input,,}" == "q" ]]; then
                echo "Exiting.  Goodbye!"
                exit 0
            fi
            ;;
        7)
            read -p "Please enter in the name of a package to search for:" searchTerm
            echo "Searching for '$searchTerm'..."
            apt list --installed | grep -i "$searchTerm"
            read -p "Press Enter to continue or 'q' to quit: " input
            echo
            if [[ "${input,,}" == "q" ]]; then
                echo "Exiting.  Goodbye!"
                exit 0
            fi
            ;;
        8)
            echo "Restarting HAL9000..."
            sudo sh ./restart.sh
            ;;
        9)
            echo "Exiting.  Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option.  Please select an option again, or 9 to exit."
            ;;
    esac
done

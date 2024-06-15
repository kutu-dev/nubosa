#!/usr/bin/env sh

info_printf() {
	printf "%s\n" "$(tput bold)[ $(tput setaf 2)INFO$(tput sgr0) ]$(tput sgr0) $1"
}

error_printf() {
	printf "%s\n" "$(tput bold)[ $(tput setaf 1)ERROR$(tput sgr0) ]$(tput sgr0) $1"
}

new_wallpaper_path=$(find ~/Pictures/wallpapers/* -type f ! -name ".DS_Store" | sort -R | head -1)

if osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$new_wallpaper_path\""; then
    info_printf "'$new_wallpaper_path' set as the background image"
else
    error_printf "Something went wrong, the file '$new_wallpaper_path' couldn't be applied as the background image"
fi

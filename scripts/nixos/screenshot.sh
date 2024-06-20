#!/usr/bin/env sh

SCREENSHOTS_PATH="$HOME/pictures/screenshots/"
SCREENSHOT_PATH="$SCREENSHOTS_PATH$(date "+%Y-%m-%d-%H-%M-%S.png")"

mkdir -p "$SCREENSHOTS_PATH"
grim "$SCREENSHOT_PATH"
system-notification "Screenshot saved to $SCREENSHOT_PATH"

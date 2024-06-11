#!/usr/bin/env sh

if ! pgrep -x "slurp" >/dev/null; then
  SCREENSHOTS_PATH="$HOME/pictures/screenshots/"
  SCREENSHOT_PATH="$SCREENSHOTS_PATH$(date "+%Y-%m-%d-%H-%M-%S.png")"

  mkdir -p "$SCREENSHOTS_PATH"
	grim -g "$(slurp -b "#000000a5")" "$SCREENSHOT_PATH"
	system-notification "Screenshot saved to $SCREENSHOT_PATH"
fi

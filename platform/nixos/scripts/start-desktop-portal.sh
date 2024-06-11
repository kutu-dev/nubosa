#!/usr/bin/env sh

sleep 1
pkill -x xdg-desktop-portal-hyprland
pkill -x xdg-desktop-portal
/usr/libexec/xdg-desktop-portal-hyprland &
sleep 2
/usr/libexec/xdg-desktop-portal &

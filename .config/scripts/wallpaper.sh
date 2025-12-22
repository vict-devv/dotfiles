#!/usr/bin/env bash

profilepic="$HOME/Pictures/profile.png"
wallpaper="$HOME/Pictures/Wallpaper/wallpaper.png"
blurredwallpaper="$HOME/Pictures/Wallpaper/blurred_wallpaper.png"
squarewallpaper="$HOME/Pictures/Wallpaper/square_wallpaper.png"

# create blurry wallpaper for lock screen
magick $wallpaper -resize 75% $blurredwallpaper

#create square wallpaper for profile
magick $profilepic -gravity Center -extent 1:1 $squarewallpaper

#generate matugen files
matugen image $wallpaper -m "light"

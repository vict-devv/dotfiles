#!/usr/bin/env bash

profilepic="~/Pictures/profile.png"
wallpaper="~/Pictures/Wallpaper/wallpaper.png"
blurredwallpaper="~/Pictures/Wallpaper/blurred_wallpaper.png"
squarewallpaper="~/Pictures/Wallpaper/square_wallpaper.png"

# create blurry wallpaper for lock screen
magick $wallpaper -resize 75% $blurredwallpaper

#create square wallpaper for profile
magick $profilepic -gravity Center -extent 1:1 $squarewallpaper
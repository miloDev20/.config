#!/usr/bin/env bash

# Carpeta de wallpapers
WALLDIR="$HOME/Wallpapers"

# Comprobar que la carpeta existe
if [ ! -d "$WALLDIR" ]; then
    notify-send "Error" "La carpeta $WALLDIR no existe"
    exit 1
fi

# Obtener lista de imágenes (puedes añadir más extensiones si quieres)
WALLPAPER=$(find "$WALLDIR" -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.webp" \
    \) -printf "%f\n" | rofi -dmenu -p "Wallpapers")

# Si no se selecciona nada, salir
[ -z "$WALLPAPER" ] && exit 0

FULLPATH="$WALLDIR/$WALLPAPER"

# Cambiar fondo con swww
swww img "$FULLPATH" \
    --transition-type any \
    --transition-fps 60 \
    --transition-duration 1

# Actualizar colores con wal
wal -i "$FULLPATH"
killall waybar
waybar & disown
pywalfox update

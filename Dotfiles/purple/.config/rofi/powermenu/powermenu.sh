#!/usr/bin/env sh

dir="$HOME/.config/rofi/powermenu"
theme='powermenu'
host="$(hostname)"

shutdown=''
reboot=''
lock=''
suspend=''
logout=''

rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -theme ${dir}/${theme}.rasi
}

run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

chosen="$(run_rofi)"

[[ -z "$chosen" ]] && exit 0

case ${chosen} in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        hyprlock
        ;;
    $suspend)
        # Проверяем наличие команд, чтобы скрипт не срал ошибками
        command -v mpc >/dev/null 2>&1 && mpc -q pause
        command -v amixer >/dev/null 2>&1 && amixer set Master mute
        systemctl suspend
        ;;
    $logout)
        hyprctl dispatch exit
        ;;
esac

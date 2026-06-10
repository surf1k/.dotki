#!/usr/bin/env sh

get_lang() {
    lang=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "'$1'") | .active_keymap' | cut -c 1-2 | tr 'A-Z' 'a-z')

    case $lang in
        en)
            lang="EN"
            ;;
        tu)
            lang="TR"
            ;;
        pe)
            lang="IR"
            ;;
        *)
            lang="None"
            ;;
    esac

    echo $lang
}

current_lang=$(get_lang "pebble-k380s")

if [[ $current_lang != "None" ]]; then
    echo "$current_lang"
    exit 0
else
    current_lang=$(get_lang "at-translated-set-2-keyboard")
    echo "$current_lang"
    exit 0
fi

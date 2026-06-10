#!/usr/bin/env sh
# Ищем активный микрофон через wpctl (игнорируем ошибки)
MIC_ID=$(wpctl status | grep -A 1 "Audio/Sources" | grep -oP "\[source \d+\]" | head -n1 | grep -oP "\d+")

if [ -z "$MIC_ID" ]; then
    echo "" # Если микрофон не найден
    exit
fi

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
    echo ""
else
    echo ""
fi

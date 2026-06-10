import subprocess
import os

# Символы для баров (от низкого к высокому)
bars = [" ", "▂", "▃", "▄", "▅", "▆", "▇", "█"]

config_path = os.path.expanduser("~/.config/waybar/scripts/cava.conf")

# Если конфига нет, создадим его
if not os.path.exists(config_path):
    with open(config_path, "w") as f:
        f.write("[general]\nbars = 10\n[output]\nmethod = raw\nraw_target = /dev/stdout\ndata_format = ascii\nascii_max_range = 7")

process = subprocess.Popen(["cava", "-p", config_path], stdout=subprocess.PIPE, text=True)

while True:
    line = process.stdout.readline().strip()
    if line:
        # Убираем лишние символы и превращаем числа в столбики
        output = "".join([bars[int(char)] for char in line if char.isdigit()])
        print(output, flush=True)
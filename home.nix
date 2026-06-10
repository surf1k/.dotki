home.pointerCursor = {
  gtk.enable = true;
  # x11.enable = true; # Раскомментируйте, если используете X11 вместо Wayland
  name = "Ghostline";
  package = pkgs.stdenv.mkDerivation {
    name = "ghostline-cursor-theme";
    src = ./ghostline-cursor-theme; # Путь к скачанному репозиторию
    installPhase = ''
      mkdir -p $out/share/icons/Ghostline
      cp -r Ghostline-Cusor-Theme/* $out/share/icons/Ghostline/
    '';
  };
  size = 24;
};

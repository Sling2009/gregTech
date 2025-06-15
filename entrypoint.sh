#!/bin/bash
set -x

# --- Standardwerte setzen, falls nicht definiert ---
MEM_MIN="${MEM_MIN:-6G}"
MEM_MAX="${MEM_MAX:-6G}"

# Prüfen, ob HOME_DIR leer ist (kein Inhalt)
if [ -z "$(ls -A "$HOME_DIR" 2>/dev/null)" ]; then
  echo "Verzeichnis $HOME_DIR ist leer. Lade und entpacke Server-Paket..."

  # Download
  curl -L "https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_${GREGTECH_VERSION}_Server_Java_17-21.zip" -o server.zip

  # Entpacken nach HOME_DIR
  unzip server.zip -d "$HOME_DIR"

  # Startscript ausführbar machen
  chmod +x "$HOME_DIR/startserver-java9.sh"

  # Zip löschen
  rm server.zip
else
  echo "Verzeichnis $HOME_DIR ist nicht leer, überspringe Download und Entpacken."
fi

#setze eula.txt
if [[ "$EULA" = "true" ]]; then
  echo "eula=true" >"${HOME_DIR}"/eula.txt
else
  echo "you have to accept EULA to install."
  exit 10
fi

# Server starten
while true; do
  java -Xms"${MEM_MIN}" -Xmx"${MEM_MAX}" -Dfml.readTimeout=180 @"${HOME_DIR}"/java9args.txt -jar "${HOME_DIR}"/lwjgl3ify-forgePatches.jar nogui
  echo "If you want to completely stop the server process now, press Ctrl+C before the time is up!"
  echo "Rebooting in:"
  for i in 12 11 10 9 8 7 6 5 4 3 2 1; do
    echo "$i..."
    sleep 1
  done
  echo "Rebooting now!"
done
